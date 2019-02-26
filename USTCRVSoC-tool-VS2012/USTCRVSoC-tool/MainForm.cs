using System;
using System.IO;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;

namespace USTCRVSoC_tool
{
    public partial class MainForm : Form
    {
        private const string RISCV_TOOLS_PATH = ".\\riscv32-elf-tools-windows\\";
        private const string VerilogHead = "module instr_rom(\n    input  logic clk, rst_n,\n    naive_bus.slave  bus\n);\nlocalparam  INSTR_CNT = 30'd";
        private const string VerilogMid = ";\nwire [0:INSTR_CNT-1] [31:0] instr_rom_cell = {\n";
        private const string VerilogTail = "};\n\nlogic [29:0] cell_rd_addr;\n\nassign bus.rd_gnt = bus.rd_req;\nassign bus.wr_gnt = bus.wr_req;\nassign cell_rd_addr = bus.rd_addr[31:2];\nalways @ (posedge clk or negedge rst_n)\n    if(~rst_n)\n        bus.rd_data <= 0;\n    else begin\n        if(bus.rd_req)\n            bus.rd_data <= (cell_rd_addr>=INSTR_CNT) ? 0 : instr_rom_cell[cell_rd_addr];\n        else\n            bus.rd_data <= 0;\n        end\n\nendmodule\n\n";
        private uint _userPortCount;

        private uint userPortCount
        {
            get
            {
                return _userPortCount;
            }
            set
            {
                _userPortCount = value;
                changeCountText(String.Format("接收: {0:D} B", _userPortCount));
            }
        }

        public MainForm()
        {
            InitializeComponent();
            InitializeCurrentPort(null, null);
        }

        private void InitializeCurrentPort(object sender, EventArgs e)
        {
            string[] ports = SerialPort.GetPortNames();
            portSelectionBox.Items.Clear();
            portSelectionBox.Items.AddRange(ports);
            if (portSelectionBox.Items.Count > 0)
            {
                portSelectionBox.SelectedIndex = 0;
            }
            else
            {
                compilePromptText.Text = "未找到串口，请插入设备，或者检查串口驱动是否安装";
            }
        }

        private void fileSelectionBtn_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.InitialDirectory = ".\\";   //注意这里写路径时要用c:\\而不是c:\
            openFileDialog.Filter = "汇编语言文件|*.S";
            openFileDialog.RestoreDirectory = true;
            openFileDialog.FilterIndex = 1;
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                fileSelectionText.Text = openFileDialog.FileName;
                try
                {
                    codeText.Text = System.IO.File.ReadAllText(openFileDialog.FileName);
                    compilePromptText.Text = "已打开文件";
                    saveBtn.Enabled = true;
                }
                catch (Exception ex)
                {
                    compilePromptText.Text = "打开文件失败\n  " + ex.Message;
                }
            }
        }

        private void saveBtn_Click(object sender, EventArgs e)
        {
            try
            {
                System.IO.File.WriteAllText(fileSelectionText.Text, codeText.Text);
                compilePromptText.Text = "  已保存文件";
            }
            catch (Exception ex)
            {
                compilePromptText.Text = "  保存文件失败\r\n" + ex.Message;
            }
        }

        private void otherSaveBtn_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.InitialDirectory = ".\\";   //注意这里写路径时要用c:\\而不是c:\
            saveFileDialog.Filter = "汇编语言文件|*.S";
            saveFileDialog.RestoreDirectory = true;
            saveFileDialog.FilterIndex = 1;
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                fileSelectionText.Text = saveFileDialog.FileName;
                try
                {
                    System.IO.File.WriteAllText(fileSelectionText.Text, codeText.Text);
                    compilePromptText.Text = "已保存文件";
                }
                catch (Exception ex)
                {
                    compilePromptText.Text = "保存文件失败\n  " + ex.Message;
                }
            }
        }

        public bool RunCmd(string path, string command, ref string msg)
        {
            try
            {
                msg = ">" + command + "\r\n\r\n";
                System.Diagnostics.Process pro = new System.Diagnostics.Process();
                pro.StartInfo.FileName = "cmd.exe";
                pro.StartInfo.CreateNoWindow = true;         // 不创建新窗口    
                pro.StartInfo.UseShellExecute = false;       // 不启用shell启动进程  
                pro.StartInfo.RedirectStandardInput = true;  // 重定向输入    
                pro.StartInfo.RedirectStandardOutput = true; // 重定向标准输出    
                pro.StartInfo.RedirectStandardError = true;
                pro.StartInfo.StandardErrorEncoding = System.Text.UTF8Encoding.UTF8;
                pro.StartInfo.StandardOutputEncoding = System.Text.UTF8Encoding.UTF8;  // 重定向错误输出  
                pro.StartInfo.WorkingDirectory = path;
                pro.Start();               //开启cmd
                pro.StandardInput.WriteLine(command);
                pro.StandardInput.AutoFlush = true;
                pro.StandardInput.WriteLine("exit"); //若是运行时间短可加入此命令
                pro.WaitForExit();//若运行时间长,使用这个,等待程序执行完退出进程
                string errorStr = pro.StandardError.ReadToEnd();
                msg += errorStr;
                pro.Close();
                return errorStr.Trim().Length == 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + "\r\n请确保工具链目录与本程序在同一目录下");
                return false;
            }
        }

        private string dumpBin(string bin_file_path)
        {
            StringBuilder strbuild = new StringBuilder();
            byte[] bin = System.IO.File.ReadAllBytes(bin_file_path);
            for (int i = 0; i < bin.Length - 3; i += 4)
            {
                for (int j = 3; j >= 0; j--)
                    strbuild.Append(bin[i + j].ToString("x2"));
                strbuild.AppendLine();
            }
            return strbuild.ToString();
        }

        private void compileBtn_Click(object sender, EventArgs e)
        {
            bool stat;
            string msg = "";
            string asm_command = "riscv32-elf-as " + fileSelectionText.Text + " -o compile_tmp.o -march=rv32i";
            string ld_command = "riscv32-elf-ld compile_tmp.o -o compile_tmp.om";
            compilePromptText.Clear();

            try
            {
                System.IO.File.WriteAllText(fileSelectionText.Text, codeText.Text);
            }
            catch (Exception ex)
            {
                compilePromptText.Text = "保存文件失败\n  " + ex.Message;
                return;
            }

            stat = RunCmd(RISCV_TOOLS_PATH, asm_command, ref msg);
            compilePromptText.AppendText(msg);
            if (!stat)
            {
                compilePromptText.AppendText("  *** 编译出错! ***");
                return;
            }

            stat = RunCmd(RISCV_TOOLS_PATH, ld_command, ref msg);
            compilePromptText.AppendText(msg);
            if (!stat)
            {
                compilePromptText.AppendText("  *** 生成om文件出错! ***");
                return;
            }

            stat = RunCmd(RISCV_TOOLS_PATH, "del compile_tmp.o", ref msg);
            compilePromptText.AppendText(msg);
            if (!stat)
            {
                compilePromptText.AppendText("  *** 删除中间文件出错! ***");
                return;
            }

            stat = RunCmd(RISCV_TOOLS_PATH, "riscv32-elf-objcopy -O binary compile_tmp.om compile_tmp.bin", ref msg);
            compilePromptText.AppendText(msg);
            if (!stat)
            {
                compilePromptText.AppendText("  *** 生成bin文件出错! ***");
                return;
            }

            stat = RunCmd(RISCV_TOOLS_PATH, "del compile_tmp.om", ref msg);
            compilePromptText.AppendText(msg);
            if (!stat)
            {
                compilePromptText.AppendText("  *** 删除中间文件出错! ***");
                return;
            }

            try
            {
                binText.Text = dumpBin(RISCV_TOOLS_PATH + "compile_tmp.bin");
                compilePromptText.AppendText("  *** 编译完成! ***");
            }
            catch
            {
                compilePromptText.AppendText("  *** 读取bin文件出错! ***");
                return;
            }
        }

        private string genVerilogRom()
        {
            StringBuilder strBuilder = new StringBuilder();
            int index = 0;
            string[] lines = binText.Text.Trim().Split();
            for (int idx = 0; idx < lines.Length; idx++)
            {
                string line = lines[idx];
                string hex_num = line.Trim();
                if (hex_num.Length <= 0)
                    continue;
                if (idx < lines.Length - 2)
                    strBuilder.Append(String.Format("    32'h{1:S},   // 0x{0:x8}\n", index * 4, hex_num));
                else
                    strBuilder.Append(String.Format("    32'h{1:S}    // 0x{0:x8}\n", index * 4, hex_num));
                index += 1;
            }
            strBuilder.Insert(0, VerilogMid);
            strBuilder.Insert(0, index.ToString());
            strBuilder.Insert(0, VerilogHead);
            strBuilder.Append(VerilogTail);
            return strBuilder.ToString();
        }

        private void saveVerilog_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.InitialDirectory = ".\\";   //注意这里写路径时要用c:\\而不是c:\
            saveFileDialog.Filter = "SystemVerilog源文件|*.sv";
            saveFileDialog.RestoreDirectory = true;
            saveFileDialog.FilterIndex = 1;
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    System.IO.File.WriteAllText(saveFileDialog.FileName, genVerilogRom());
                    compilePromptText.Text = "已保存 Verilog ROM 文件";
                }
                catch (Exception ex)
                {
                    compilePromptText.Text = "保存 Verilog ROM 文件失败\r\n" + ex.Message;
                }
            }
        }

        private bool serialSessionA(string send, ref string response)
        {
            return serialSessionTry(send, ref response, "");
        }

        private bool serialSessionB(string send, string respectResponse)
        {
            string response = "";
            return serialSessionTry(send, ref response, respectResponse);
        }

        private bool serialSessionTry(string send, ref string response, string respectResponse, int try_time = 3)
        {
            for (int i = 0; i < try_time; i++)
                if (serialSend(send))
                    if (serialRead(ref response, respectResponse))
                        return true;
            compilePromptText.AppendText("  *** 串口调试多次尝试失败 ***\r\n");
            return false;
        }

        private bool serialSend(string send)
        {
            compilePromptText.AppendText("send: " + send);
            try
            {
                serialPort.Write(send + "\n");
            }
            catch (Exception ex)
            {
                compilePromptText.AppendText("    " + ex.Message + "\r\n");
                return false;
            }
            return true;
        }

        private bool serialRead(ref string response, string respectResponse)
        {
            try
            {
                for (int i = 0; i < 8; i++)
                {
                    response = serialPort.ReadLine().Trim();
                    bool is_respect = respectResponse.Equals("") || respectResponse.Equals(response);
                    if (is_respect)
                    {
                        compilePromptText.AppendText("    response: " + response + "\r\n");
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                compilePromptText.AppendText("    " + ex.Message + "\r\n");
                return false;
            }
            compilePromptText.AppendText("    response: *** 超时 ***\r\n" + response);
            return false;
        }

        private uint getBootAddr()
        {
            return Convert.ToUInt32(bootAddrTextBox.Text, 16);
        }

        private void programBtn_Click(object sender, EventArgs e)
        {
            compilePromptText.Clear();

            uint boot_addr;
            try
            {
                boot_addr = getBootAddr();
            }
            catch (Exception ex)
            {
                compilePromptText.AppendText("  *** Boot Addr格式有误 ***\r\n  " + ex.Message);
                return;
            }

            if (!serialPort.IsOpen)
            {
                serialPort.PortName = portSelectionBox.Text;
                try
                {
                    serialPort.Open();
                }
                catch (Exception ex)
                {
                    compilePromptText.AppendText("  *** 打开串口出错 ***\r\n  " + ex.Message);
                    refreshPortStatus();
                    return;
                }
            }
            refreshPortStatus();

            if (!serialSessionB("s", "debug"))
            {
                return;
            }

            uint index = 0;
            foreach (string line in binText.Text.Split())
            {
                string hex_num = line.Trim();
                if (hex_num.Length <= 0)
                    continue;
                string send_str = String.Format("{0:x8} {1:S}", boot_addr + index * 4, hex_num);
                index++;

                if (!serialSessionB(send_str, "wr done"))
                {
                    return;
                }
            }

            if (!serialSessionB(string.Format("r{0:x8}", boot_addr), "rst done"))
            {
                return;
            }

            compilePromptText.AppendText(" *** 烧录成功 ***\r\n");
        }

        private void userPortOpenCloseBtn_Click(object sender, EventArgs e)
        {
            if (userPortOpenCloseBtn.Text == "打开")
            {
                serialPort.PortName = portSelectionBox.Text;
                try
                {
                    serialPort.Open();
                    userPortCount = 0;
                }
                catch (Exception ex)
                {
                    compilePromptText.AppendText("  *** 打开串口出错 ***\r\n  " + ex.Message);
                }
            }
            else
            {
                serialPort.Close();
            }
            refreshPortStatus();
        }

        private void refreshPortStatus()
        {
            if (serialPort.IsOpen)
                userPortOpenCloseBtn.Text = "关闭";
            else
                userPortOpenCloseBtn.Text = "打开";
        }

        public delegate void changeTextHandler(object str);

        private void appendUserPortText(object str)
        {
            if (userPortTextBox.InvokeRequired == true)
            {
                changeTextHandler ct = new changeTextHandler(appendUserPortText);
                userPortTextBox.Invoke(ct, new object[] { str });
            }
            else
            {
                userPortTextBox.AppendText(str.ToString());
            }
        }

        private void changeCountText(object str)
        {
            if (UserPortRecvCountLabel.InvokeRequired == true)
            {
                changeTextHandler ct = new changeTextHandler(changeCountText);
                UserPortRecvCountLabel.Invoke(ct, new object[] { str });
            }
            else
            {
                UserPortRecvCountLabel.Text = str.ToString();
            }
        }


        private void userPortClearBtn_Click(object sender, EventArgs e)
        {
            userPortTextBox.Clear();
        }

        private void serialPort_DataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {
            SerialPort sp = (SerialPort)sender;
            try
            {
                string recvdata = sp.ReadExisting();
                if (userPortShowHex.Checked)
                {
                    StringBuilder sb = new StringBuilder();
                    foreach (byte ch in recvdata)
                    {
                        sb.Append(String.Format("{0:X2} ", ch));
                    }
                    appendUserPortText(sb.ToString());
                }
                else
                {
                    appendUserPortText(recvdata);
                }
                userPortCount += (uint)recvdata.Length;
            }
            catch { }
        }
    }
}

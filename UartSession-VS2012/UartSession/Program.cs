using System;
using System.IO.Ports;

namespace UartSession
{
    class Program
    {
        static SerialPort port = new SerialPort();

        static void DataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {
            SerialPort sp = (SerialPort)sender;
            try
            {
                string recvdata = sp.ReadExisting();
                Console.Write(recvdata);
            }
            catch { }
        }

        static void Main(string[] args)
        {
            int index;
            string input;

            port.BaudRate = 115200;
            port.DataBits = 8;
            port.Parity = Parity.None;
            port.StopBits = StopBits.One;
            port.DtrEnable = false;
            port.RtsEnable = false;
            port.ReadTimeout = 1000;
            port.WriteTimeout = 500;
            port.DataReceived += new SerialDataReceivedEventHandler(DataReceived);
            
            while (true)
            {
                int set_baud = -1;
                int ser_no = -1;
                string[] ser_names = { };

                Console.WriteLine("\n\n命令列表:");
                try { ser_names = SerialPort.GetPortNames(); }catch { }
                for (index = 0; index < ser_names.Length; index++)
                    Console.WriteLine("    {0:#0} : 打开 {1:S}", index, ser_names[index]);
                if(index<=0)
                    Console.WriteLine("      (* 未找到端口 *)");
                Console.WriteLine("    baud [数字] : 设置COM口波特率，例如 baud 9600 表示设置波特率为9600");
                Console.WriteLine("    refresh  : 刷新COM口列表");
                Console.WriteLine("    exit  : 退出");
                
                Console.Write("\n当前波特率为{0:D}\n请输入你的命令:", port.BaudRate);
                input = Console.ReadLine().Trim();
                try { ser_no = Convert.ToInt32(input); } catch {}
                try{
                    string[] tmps = input.Split();
                    if (tmps.Length == 2 && tmps[0] == "baud")
                        set_baud = Convert.ToInt32(tmps[1]);
                }catch{}

                if (input == "exit")
                    break;
                else if (input == "refresh")
                {
                    Console.WriteLine("\n\n");
                    continue;
                }
                else if (set_baud>0)
                {
                    try
                    {
                        port.BaudRate = set_baud;
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("  *** 错误: {0:S} ***", ex.Message);
                        continue;
                    }
                }
                else if (ser_no >= 0 && ser_no < index)
                {
                    string ser_name = ser_names[ser_no];
                    try
                    {
                        port.PortName = ser_name;
                        port.Open();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("  *** 开启串口错误: {0:S} ***", ex.Message);
                        continue;
                    }
                    Console.WriteLine("  已经打开{0:S}，请输入发送数据，输入exit退出", ser_name);
                    while (true)
                    {
                        input = Console.ReadLine().Trim();
                        if (input == "exit")
                            break;
                        try { port.WriteLine(input); }
                        catch { }
                    }
                    port.Close();
                    break;
                }
                else
                    Console.WriteLine("  *** 格式错误 ***");
            }
        }
    }
}

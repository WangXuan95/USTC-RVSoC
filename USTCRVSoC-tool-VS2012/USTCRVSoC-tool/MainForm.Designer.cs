namespace USTCRVSoC_tool
{
    partial class MainForm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.fileSelectionText = new System.Windows.Forms.TextBox();
            this.fileSelectionBtn = new System.Windows.Forms.Button();
            this.compileGroup = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.otherSaveBtn = new System.Windows.Forms.Button();
            this.saveBtn = new System.Windows.Forms.Button();
            this.codeText = new System.Windows.Forms.TextBox();
            this.compilePromptText = new System.Windows.Forms.TextBox();
            this.HexStreamGroup = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.binText = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel5 = new System.Windows.Forms.TableLayoutPanel();
            this.saveVerilog = new System.Windows.Forms.Button();
            this.compileBtn = new System.Windows.Forms.Button();
            this.tableLayoutPanel6 = new System.Windows.Forms.TableLayoutPanel();
            this.programBtn = new System.Windows.Forms.Button();
            this.portSelectionBox = new System.Windows.Forms.ComboBox();
            this.bootAddrGroup = new System.Windows.Forms.GroupBox();
            this.bootAddrTextBox = new System.Windows.Forms.TextBox();
            this.MainLayout = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel7 = new System.Windows.Forms.TableLayoutPanel();
            this.userPortTextBox = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel8 = new System.Windows.Forms.TableLayoutPanel();
            this.userPortClearBtn = new System.Windows.Forms.Button();
            this.userPortOpenCloseBtn = new System.Windows.Forms.Button();
            this.userPortShowHex = new System.Windows.Forms.CheckBox();
            this.UserPortRecvCountLabel = new System.Windows.Forms.Label();
            this.内存DumpGroup = new System.Windows.Forms.GroupBox();
            this.内存DumpLayout = new System.Windows.Forms.TableLayoutPanel();
            this.内存内容 = new System.Windows.Forms.TextBox();
            this.地址长度指定Layout = new System.Windows.Forms.TableLayoutPanel();
            this.起始地址 = new System.Windows.Forms.TextBox();
            this.长度 = new System.Windows.Forms.TextBox();
            this.长度Title = new System.Windows.Forms.Label();
            this.起始地址Title = new System.Windows.Forms.Label();
            this.DUMP内存 = new System.Windows.Forms.Button();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.compileGroup.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.HexStreamGroup.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            this.tableLayoutPanel6.SuspendLayout();
            this.bootAddrGroup.SuspendLayout();
            this.MainLayout.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tableLayoutPanel7.SuspendLayout();
            this.tableLayoutPanel8.SuspendLayout();
            this.内存DumpGroup.SuspendLayout();
            this.内存DumpLayout.SuspendLayout();
            this.地址长度指定Layout.SuspendLayout();
            this.SuspendLayout();
            // 
            // fileSelectionText
            // 
            this.fileSelectionText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.fileSelectionText.Font = new System.Drawing.Font("宋体", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.fileSelectionText.Location = new System.Drawing.Point(5, 5);
            this.fileSelectionText.Margin = new System.Windows.Forms.Padding(5);
            this.fileSelectionText.Name = "fileSelectionText";
            this.fileSelectionText.ReadOnly = true;
            this.fileSelectionText.Size = new System.Drawing.Size(187, 28);
            this.fileSelectionText.TabIndex = 0;
            // 
            // fileSelectionBtn
            // 
            this.fileSelectionBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.fileSelectionBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.fileSelectionBtn.Location = new System.Drawing.Point(200, 3);
            this.fileSelectionBtn.Name = "fileSelectionBtn";
            this.fileSelectionBtn.Size = new System.Drawing.Size(114, 34);
            this.fileSelectionBtn.TabIndex = 1;
            this.fileSelectionBtn.Text = "打开...";
            this.fileSelectionBtn.UseVisualStyleBackColor = true;
            this.fileSelectionBtn.Click += new System.EventHandler(this.fileSelectionBtn_Click);
            // 
            // compileGroup
            // 
            this.compileGroup.Controls.Add(this.tableLayoutPanel3);
            this.compileGroup.Dock = System.Windows.Forms.DockStyle.Fill;
            this.compileGroup.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.compileGroup.Location = new System.Drawing.Point(7, 7);
            this.compileGroup.Margin = new System.Windows.Forms.Padding(7);
            this.compileGroup.Name = "compileGroup";
            this.compileGroup.Size = new System.Drawing.Size(563, 64);
            this.compileGroup.TabIndex = 2;
            this.compileGroup.TabStop = false;
            this.compileGroup.Text = "文件";
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 4;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120F));
            this.tableLayoutPanel3.Controls.Add(this.otherSaveBtn, 3, 0);
            this.tableLayoutPanel3.Controls.Add(this.saveBtn, 2, 0);
            this.tableLayoutPanel3.Controls.Add(this.fileSelectionBtn, 1, 0);
            this.tableLayoutPanel3.Controls.Add(this.fileSelectionText, 0, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(3, 21);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 1;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(557, 40);
            this.tableLayoutPanel3.TabIndex = 7;
            // 
            // otherSaveBtn
            // 
            this.otherSaveBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.otherSaveBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.otherSaveBtn.Location = new System.Drawing.Point(440, 3);
            this.otherSaveBtn.Name = "otherSaveBtn";
            this.otherSaveBtn.Size = new System.Drawing.Size(114, 34);
            this.otherSaveBtn.TabIndex = 5;
            this.otherSaveBtn.Text = "另存...";
            this.otherSaveBtn.UseVisualStyleBackColor = true;
            this.otherSaveBtn.Click += new System.EventHandler(this.otherSaveBtn_Click);
            // 
            // saveBtn
            // 
            this.saveBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.saveBtn.Enabled = false;
            this.saveBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.saveBtn.Location = new System.Drawing.Point(320, 3);
            this.saveBtn.Name = "saveBtn";
            this.saveBtn.Size = new System.Drawing.Size(114, 34);
            this.saveBtn.TabIndex = 4;
            this.saveBtn.Text = "保存";
            this.saveBtn.UseVisualStyleBackColor = true;
            this.saveBtn.Click += new System.EventHandler(this.saveBtn_Click);
            // 
            // codeText
            // 
            this.codeText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.codeText.Font = new System.Drawing.Font("Consolas", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.codeText.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(64)))), ((int)(((byte)(64)))));
            this.codeText.Location = new System.Drawing.Point(3, 81);
            this.codeText.Multiline = true;
            this.codeText.Name = "codeText";
            this.codeText.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.codeText.Size = new System.Drawing.Size(571, 504);
            this.codeText.TabIndex = 4;
            // 
            // compilePromptText
            // 
            this.compilePromptText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.compilePromptText.Font = new System.Drawing.Font("Consolas", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.compilePromptText.Location = new System.Drawing.Point(3, 591);
            this.compilePromptText.Multiline = true;
            this.compilePromptText.Name = "compilePromptText";
            this.compilePromptText.ReadOnly = true;
            this.compilePromptText.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.compilePromptText.Size = new System.Drawing.Size(571, 156);
            this.compilePromptText.TabIndex = 3;
            // 
            // HexStreamGroup
            // 
            this.HexStreamGroup.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.HexStreamGroup.Controls.Add(this.tableLayoutPanel4);
            this.HexStreamGroup.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.HexStreamGroup.Location = new System.Drawing.Point(586, 3);
            this.HexStreamGroup.Name = "HexStreamGroup";
            this.HexStreamGroup.Size = new System.Drawing.Size(244, 750);
            this.HexStreamGroup.TabIndex = 5;
            this.HexStreamGroup.TabStop = false;
            this.HexStreamGroup.Text = "指令流";
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.ColumnCount = 1;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel4.Controls.Add(this.binText, 0, 3);
            this.tableLayoutPanel4.Controls.Add(this.tableLayoutPanel5, 0, 0);
            this.tableLayoutPanel4.Controls.Add(this.tableLayoutPanel6, 0, 1);
            this.tableLayoutPanel4.Controls.Add(this.bootAddrGroup, 0, 2);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(3, 21);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 4;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 50F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 50F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 60F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel4.Size = new System.Drawing.Size(238, 726);
            this.tableLayoutPanel4.TabIndex = 0;
            // 
            // binText
            // 
            this.binText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.binText.Font = new System.Drawing.Font("Consolas", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.binText.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.binText.Location = new System.Drawing.Point(3, 163);
            this.binText.Multiline = true;
            this.binText.Name = "binText";
            this.binText.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.binText.Size = new System.Drawing.Size(232, 560);
            this.binText.TabIndex = 5;
            // 
            // tableLayoutPanel5
            // 
            this.tableLayoutPanel5.ColumnCount = 2;
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 30F));
            this.tableLayoutPanel5.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 70F));
            this.tableLayoutPanel5.Controls.Add(this.saveVerilog, 1, 0);
            this.tableLayoutPanel5.Controls.Add(this.compileBtn, 0, 0);
            this.tableLayoutPanel5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel5.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel5.Name = "tableLayoutPanel5";
            this.tableLayoutPanel5.RowCount = 1;
            this.tableLayoutPanel5.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel5.Size = new System.Drawing.Size(232, 44);
            this.tableLayoutPanel5.TabIndex = 0;
            // 
            // saveVerilog
            // 
            this.saveVerilog.Dock = System.Windows.Forms.DockStyle.Fill;
            this.saveVerilog.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.saveVerilog.Location = new System.Drawing.Point(72, 3);
            this.saveVerilog.Name = "saveVerilog";
            this.saveVerilog.Size = new System.Drawing.Size(157, 38);
            this.saveVerilog.TabIndex = 2;
            this.saveVerilog.Text = "保存指令流 (Verilog)";
            this.saveVerilog.UseVisualStyleBackColor = true;
            this.saveVerilog.Click += new System.EventHandler(this.saveVerilog_Click);
            // 
            // compileBtn
            // 
            this.compileBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.compileBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.compileBtn.Location = new System.Drawing.Point(3, 3);
            this.compileBtn.Name = "compileBtn";
            this.compileBtn.Size = new System.Drawing.Size(63, 38);
            this.compileBtn.TabIndex = 0;
            this.compileBtn.Text = "汇编";
            this.compileBtn.UseVisualStyleBackColor = true;
            this.compileBtn.Click += new System.EventHandler(this.compileBtn_Click);
            // 
            // tableLayoutPanel6
            // 
            this.tableLayoutPanel6.ColumnCount = 2;
            this.tableLayoutPanel6.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel6.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel6.Controls.Add(this.programBtn, 1, 0);
            this.tableLayoutPanel6.Controls.Add(this.portSelectionBox, 0, 0);
            this.tableLayoutPanel6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel6.Location = new System.Drawing.Point(3, 53);
            this.tableLayoutPanel6.Name = "tableLayoutPanel6";
            this.tableLayoutPanel6.RowCount = 1;
            this.tableLayoutPanel6.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel6.Size = new System.Drawing.Size(232, 44);
            this.tableLayoutPanel6.TabIndex = 1;
            // 
            // programBtn
            // 
            this.programBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.programBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.programBtn.Location = new System.Drawing.Point(157, 3);
            this.programBtn.Name = "programBtn";
            this.programBtn.Size = new System.Drawing.Size(72, 38);
            this.programBtn.TabIndex = 3;
            this.programBtn.Text = "烧写";
            this.programBtn.UseVisualStyleBackColor = true;
            this.programBtn.Click += new System.EventHandler(this.programBtn_Click);
            // 
            // portSelectionBox
            // 
            this.portSelectionBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.portSelectionBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.portSelectionBox.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.portSelectionBox.FormattingEnabled = true;
            this.portSelectionBox.Location = new System.Drawing.Point(3, 3);
            this.portSelectionBox.Name = "portSelectionBox";
            this.portSelectionBox.Size = new System.Drawing.Size(148, 28);
            this.portSelectionBox.TabIndex = 0;
            this.portSelectionBox.DropDown += new System.EventHandler(this.InitializeCurrentPort);
            // 
            // bootAddrGroup
            // 
            this.bootAddrGroup.Controls.Add(this.bootAddrTextBox);
            this.bootAddrGroup.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bootAddrGroup.Location = new System.Drawing.Point(3, 103);
            this.bootAddrGroup.Name = "bootAddrGroup";
            this.bootAddrGroup.Size = new System.Drawing.Size(232, 54);
            this.bootAddrGroup.TabIndex = 6;
            this.bootAddrGroup.TabStop = false;
            this.bootAddrGroup.Text = "BOOT地址";
            // 
            // bootAddrTextBox
            // 
            this.bootAddrTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bootAddrTextBox.Font = new System.Drawing.Font("宋体", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.bootAddrTextBox.Location = new System.Drawing.Point(3, 21);
            this.bootAddrTextBox.Margin = new System.Windows.Forms.Padding(5);
            this.bootAddrTextBox.Name = "bootAddrTextBox";
            this.bootAddrTextBox.Size = new System.Drawing.Size(226, 28);
            this.bootAddrTextBox.TabIndex = 1;
            this.bootAddrTextBox.Text = "00008000";
            this.bootAddrTextBox.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // MainLayout
            // 
            this.MainLayout.ColumnCount = 4;
            this.MainLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.MainLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 250F));
            this.MainLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 250F));
            this.MainLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 380F));
            this.MainLayout.Controls.Add(this.HexStreamGroup, 1, 0);
            this.MainLayout.Controls.Add(this.tableLayoutPanel2, 0, 0);
            this.MainLayout.Controls.Add(this.groupBox1, 2, 0);
            this.MainLayout.Controls.Add(this.内存DumpGroup, 3, 0);
            this.MainLayout.Dock = System.Windows.Forms.DockStyle.Fill;
            this.MainLayout.Location = new System.Drawing.Point(0, 0);
            this.MainLayout.Name = "MainLayout";
            this.MainLayout.RowCount = 1;
            this.MainLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.MainLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.MainLayout.Size = new System.Drawing.Size(1463, 756);
            this.MainLayout.TabIndex = 6;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 1;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.Controls.Add(this.compileGroup, 0, 0);
            this.tableLayoutPanel2.Controls.Add(this.codeText, 0, 1);
            this.tableLayoutPanel2.Controls.Add(this.compilePromptText, 0, 2);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 3;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 78F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 76F));
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 24F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(577, 750);
            this.tableLayoutPanel2.TabIndex = 6;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tableLayoutPanel7);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(836, 3);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(244, 750);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "串口查看";
            // 
            // tableLayoutPanel7
            // 
            this.tableLayoutPanel7.ColumnCount = 1;
            this.tableLayoutPanel7.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel7.Controls.Add(this.userPortTextBox, 0, 1);
            this.tableLayoutPanel7.Controls.Add(this.tableLayoutPanel8, 0, 0);
            this.tableLayoutPanel7.Controls.Add(this.UserPortRecvCountLabel, 0, 2);
            this.tableLayoutPanel7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel7.Location = new System.Drawing.Point(3, 21);
            this.tableLayoutPanel7.Name = "tableLayoutPanel7";
            this.tableLayoutPanel7.RowCount = 3;
            this.tableLayoutPanel7.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 90F));
            this.tableLayoutPanel7.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel7.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
            this.tableLayoutPanel7.Size = new System.Drawing.Size(238, 726);
            this.tableLayoutPanel7.TabIndex = 0;
            // 
            // userPortTextBox
            // 
            this.userPortTextBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.userPortTextBox.Font = new System.Drawing.Font("Consolas", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.userPortTextBox.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(64)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            this.userPortTextBox.Location = new System.Drawing.Point(3, 93);
            this.userPortTextBox.Multiline = true;
            this.userPortTextBox.Name = "userPortTextBox";
            this.userPortTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.userPortTextBox.Size = new System.Drawing.Size(232, 590);
            this.userPortTextBox.TabIndex = 6;
            // 
            // tableLayoutPanel8
            // 
            this.tableLayoutPanel8.ColumnCount = 2;
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel8.Controls.Add(this.userPortClearBtn, 1, 1);
            this.tableLayoutPanel8.Controls.Add(this.userPortOpenCloseBtn, 1, 0);
            this.tableLayoutPanel8.Controls.Add(this.userPortShowHex, 0, 1);
            this.tableLayoutPanel8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel8.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel8.Name = "tableLayoutPanel8";
            this.tableLayoutPanel8.RowCount = 2;
            this.tableLayoutPanel8.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.Size = new System.Drawing.Size(232, 84);
            this.tableLayoutPanel8.TabIndex = 2;
            // 
            // userPortClearBtn
            // 
            this.userPortClearBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortClearBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.userPortClearBtn.Location = new System.Drawing.Point(157, 45);
            this.userPortClearBtn.Name = "userPortClearBtn";
            this.userPortClearBtn.Size = new System.Drawing.Size(72, 36);
            this.userPortClearBtn.TabIndex = 4;
            this.userPortClearBtn.Text = "清空";
            this.userPortClearBtn.UseVisualStyleBackColor = true;
            this.userPortClearBtn.Click += new System.EventHandler(this.userPortClearBtn_Click);
            // 
            // userPortOpenCloseBtn
            // 
            this.userPortOpenCloseBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortOpenCloseBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.userPortOpenCloseBtn.Location = new System.Drawing.Point(157, 3);
            this.userPortOpenCloseBtn.Name = "userPortOpenCloseBtn";
            this.userPortOpenCloseBtn.Size = new System.Drawing.Size(72, 36);
            this.userPortOpenCloseBtn.TabIndex = 3;
            this.userPortOpenCloseBtn.Text = "打开";
            this.userPortOpenCloseBtn.UseVisualStyleBackColor = true;
            this.userPortOpenCloseBtn.Click += new System.EventHandler(this.userPortOpenCloseBtn_Click);
            // 
            // userPortShowHex
            // 
            this.userPortShowHex.AutoSize = true;
            this.userPortShowHex.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortShowHex.Location = new System.Drawing.Point(3, 45);
            this.userPortShowHex.Name = "userPortShowHex";
            this.userPortShowHex.Size = new System.Drawing.Size(148, 36);
            this.userPortShowHex.TabIndex = 5;
            this.userPortShowHex.Text = "十六进制显示";
            this.userPortShowHex.UseVisualStyleBackColor = true;
            // 
            // UserPortRecvCountLabel
            // 
            this.UserPortRecvCountLabel.AutoSize = true;
            this.UserPortRecvCountLabel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.UserPortRecvCountLabel.Location = new System.Drawing.Point(3, 689);
            this.UserPortRecvCountLabel.Margin = new System.Windows.Forms.Padding(3);
            this.UserPortRecvCountLabel.Name = "UserPortRecvCountLabel";
            this.UserPortRecvCountLabel.Size = new System.Drawing.Size(232, 34);
            this.UserPortRecvCountLabel.TabIndex = 7;
            this.UserPortRecvCountLabel.Text = "接收: 0 B";
            // 
            // 内存DumpGroup
            // 
            this.内存DumpGroup.Controls.Add(this.内存DumpLayout);
            this.内存DumpGroup.Dock = System.Windows.Forms.DockStyle.Fill;
            this.内存DumpGroup.Location = new System.Drawing.Point(1086, 3);
            this.内存DumpGroup.Name = "内存DumpGroup";
            this.内存DumpGroup.Size = new System.Drawing.Size(374, 750);
            this.内存DumpGroup.TabIndex = 8;
            this.内存DumpGroup.TabStop = false;
            this.内存DumpGroup.Text = "内存DUMP";
            // 
            // 内存DumpLayout
            // 
            this.内存DumpLayout.ColumnCount = 1;
            this.内存DumpLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.内存DumpLayout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.内存DumpLayout.Controls.Add(this.内存内容, 0, 2);
            this.内存DumpLayout.Controls.Add(this.地址长度指定Layout, 0, 0);
            this.内存DumpLayout.Controls.Add(this.DUMP内存, 0, 1);
            this.内存DumpLayout.Dock = System.Windows.Forms.DockStyle.Fill;
            this.内存DumpLayout.Location = new System.Drawing.Point(3, 21);
            this.内存DumpLayout.Name = "内存DumpLayout";
            this.内存DumpLayout.RowCount = 3;
            this.内存DumpLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 85F));
            this.内存DumpLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 40F));
            this.内存DumpLayout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.内存DumpLayout.Size = new System.Drawing.Size(368, 726);
            this.内存DumpLayout.TabIndex = 1;
            // 
            // 内存内容
            // 
            this.内存内容.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.内存内容.Font = new System.Drawing.Font("Consolas", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.内存内容.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.内存内容.Location = new System.Drawing.Point(3, 128);
            this.内存内容.Multiline = true;
            this.内存内容.Name = "内存内容";
            this.内存内容.ReadOnly = true;
            this.内存内容.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.内存内容.Size = new System.Drawing.Size(362, 595);
            this.内存内容.TabIndex = 6;
            // 
            // 地址长度指定Layout
            // 
            this.地址长度指定Layout.ColumnCount = 2;
            this.地址长度指定Layout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.地址长度指定Layout.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.地址长度指定Layout.Controls.Add(this.起始地址, 1, 0);
            this.地址长度指定Layout.Controls.Add(this.长度, 1, 1);
            this.地址长度指定Layout.Controls.Add(this.长度Title, 0, 1);
            this.地址长度指定Layout.Controls.Add(this.起始地址Title, 0, 0);
            this.地址长度指定Layout.Dock = System.Windows.Forms.DockStyle.Fill;
            this.地址长度指定Layout.Location = new System.Drawing.Point(3, 3);
            this.地址长度指定Layout.Name = "地址长度指定Layout";
            this.地址长度指定Layout.RowCount = 2;
            this.地址长度指定Layout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.地址长度指定Layout.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.地址长度指定Layout.Size = new System.Drawing.Size(362, 79);
            this.地址长度指定Layout.TabIndex = 0;
            // 
            // 起始地址
            // 
            this.起始地址.Dock = System.Windows.Forms.DockStyle.Fill;
            this.起始地址.Font = new System.Drawing.Font("宋体", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.起始地址.Location = new System.Drawing.Point(186, 5);
            this.起始地址.Margin = new System.Windows.Forms.Padding(5);
            this.起始地址.Name = "起始地址";
            this.起始地址.Size = new System.Drawing.Size(171, 28);
            this.起始地址.TabIndex = 4;
            this.起始地址.Text = "00010000";
            this.起始地址.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // 长度
            // 
            this.长度.Dock = System.Windows.Forms.DockStyle.Fill;
            this.长度.Font = new System.Drawing.Font("宋体", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.长度.Location = new System.Drawing.Point(186, 44);
            this.长度.Margin = new System.Windows.Forms.Padding(5);
            this.长度.Name = "长度";
            this.长度.Size = new System.Drawing.Size(171, 28);
            this.长度.TabIndex = 3;
            this.长度.Text = "80";
            this.长度.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // 长度Title
            // 
            this.长度Title.AutoSize = true;
            this.长度Title.Dock = System.Windows.Forms.DockStyle.Fill;
            this.长度Title.Location = new System.Drawing.Point(3, 39);
            this.长度Title.Name = "长度Title";
            this.长度Title.Size = new System.Drawing.Size(175, 40);
            this.长度Title.TabIndex = 2;
            this.长度Title.Text = "长度(16进制):";
            this.长度Title.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // 起始地址Title
            // 
            this.起始地址Title.AutoSize = true;
            this.起始地址Title.Dock = System.Windows.Forms.DockStyle.Fill;
            this.起始地址Title.Location = new System.Drawing.Point(3, 0);
            this.起始地址Title.Name = "起始地址Title";
            this.起始地址Title.Size = new System.Drawing.Size(175, 39);
            this.起始地址Title.TabIndex = 0;
            this.起始地址Title.Text = "起始地址(16进制)";
            this.起始地址Title.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // DUMP内存
            // 
            this.DUMP内存.Dock = System.Windows.Forms.DockStyle.Fill;
            this.DUMP内存.Location = new System.Drawing.Point(3, 88);
            this.DUMP内存.Name = "DUMP内存";
            this.DUMP内存.Size = new System.Drawing.Size(362, 34);
            this.DUMP内存.TabIndex = 1;
            this.DUMP内存.Text = "DUMP内存";
            this.DUMP内存.UseVisualStyleBackColor = true;
            this.DUMP内存.Click += new System.EventHandler(this.DUMP内存_Click);
            // 
            // serialPort
            // 
            this.serialPort.BaudRate = 115200;
            this.serialPort.ReadTimeout = 50;
            this.serialPort.WriteTimeout = 300;
            this.serialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort_DataReceived);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1463, 756);
            this.Controls.Add(this.MainLayout);
            this.Name = "MainForm";
            this.Text = "USTCRVSoC 辅助工具";
            this.compileGroup.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            this.tableLayoutPanel3.PerformLayout();
            this.HexStreamGroup.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            this.tableLayoutPanel4.PerformLayout();
            this.tableLayoutPanel5.ResumeLayout(false);
            this.tableLayoutPanel6.ResumeLayout(false);
            this.bootAddrGroup.ResumeLayout(false);
            this.bootAddrGroup.PerformLayout();
            this.MainLayout.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel2.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.tableLayoutPanel7.ResumeLayout(false);
            this.tableLayoutPanel7.PerformLayout();
            this.tableLayoutPanel8.ResumeLayout(false);
            this.tableLayoutPanel8.PerformLayout();
            this.内存DumpGroup.ResumeLayout(false);
            this.内存DumpLayout.ResumeLayout(false);
            this.内存DumpLayout.PerformLayout();
            this.地址长度指定Layout.ResumeLayout(false);
            this.地址长度指定Layout.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TextBox fileSelectionText;
        private System.Windows.Forms.Button fileSelectionBtn;
        private System.Windows.Forms.GroupBox compileGroup;
        private System.Windows.Forms.TextBox compilePromptText;
        private System.Windows.Forms.TextBox codeText;
        private System.Windows.Forms.Button saveBtn;
        private System.Windows.Forms.GroupBox HexStreamGroup;
        private System.Windows.Forms.TableLayoutPanel MainLayout;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel2;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel3;
        private System.Windows.Forms.Button otherSaveBtn;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel4;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel5;
        private System.Windows.Forms.Button saveVerilog;
        private System.Windows.Forms.Button compileBtn;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel6;
        private System.Windows.Forms.Button programBtn;
        private System.Windows.Forms.ComboBox portSelectionBox;
        private System.Windows.Forms.TextBox binText;
        private System.IO.Ports.SerialPort serialPort;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox bootAddrGroup;
        private System.Windows.Forms.TextBox bootAddrTextBox;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel7;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel8;
        private System.Windows.Forms.Button userPortOpenCloseBtn;
        private System.Windows.Forms.TextBox userPortTextBox;
        private System.Windows.Forms.Button userPortClearBtn;
        private System.Windows.Forms.CheckBox userPortShowHex;
        private System.Windows.Forms.Label UserPortRecvCountLabel;
        private System.Windows.Forms.GroupBox 内存DumpGroup;
        private System.Windows.Forms.TableLayoutPanel 内存DumpLayout;
        private System.Windows.Forms.TextBox 内存内容;
        private System.Windows.Forms.TableLayoutPanel 地址长度指定Layout;
        private System.Windows.Forms.TextBox 起始地址;
        private System.Windows.Forms.TextBox 长度;
        private System.Windows.Forms.Label 长度Title;
        private System.Windows.Forms.Label 起始地址Title;
        private System.Windows.Forms.Button DUMP内存;

    }
}


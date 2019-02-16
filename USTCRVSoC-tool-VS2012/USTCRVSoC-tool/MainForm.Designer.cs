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
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.tableLayoutPanel7 = new System.Windows.Forms.TableLayoutPanel();
            this.userPortTextBox = new System.Windows.Forms.TextBox();
            this.tableLayoutPanel8 = new System.Windows.Forms.TableLayoutPanel();
            this.userPortClearBtn = new System.Windows.Forms.Button();
            this.userPortOpenCloseBtn = new System.Windows.Forms.Button();
            this.userPortSelectionBox = new System.Windows.Forms.ComboBox();
            this.userPortShowHex = new System.Windows.Forms.CheckBox();
            this.UserPortRecvCountLabel = new System.Windows.Forms.Label();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.UserSerialPort = new System.IO.Ports.SerialPort(this.components);
            this.compileGroup.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.HexStreamGroup.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            this.tableLayoutPanel5.SuspendLayout();
            this.tableLayoutPanel6.SuspendLayout();
            this.bootAddrGroup.SuspendLayout();
            this.tableLayoutPanel1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.tableLayoutPanel7.SuspendLayout();
            this.tableLayoutPanel8.SuspendLayout();
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
            this.fileSelectionText.Size = new System.Drawing.Size(304, 28);
            this.fileSelectionText.TabIndex = 0;
            // 
            // fileSelectionBtn
            // 
            this.fileSelectionBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.fileSelectionBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.fileSelectionBtn.Location = new System.Drawing.Point(317, 3);
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
            this.compileGroup.Size = new System.Drawing.Size(680, 64);
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
            this.tableLayoutPanel3.Size = new System.Drawing.Size(674, 40);
            this.tableLayoutPanel3.TabIndex = 7;
            // 
            // otherSaveBtn
            // 
            this.otherSaveBtn.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.otherSaveBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.otherSaveBtn.Location = new System.Drawing.Point(557, 3);
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
            this.saveBtn.Location = new System.Drawing.Point(437, 3);
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
            this.codeText.Size = new System.Drawing.Size(688, 444);
            this.codeText.TabIndex = 4;
            // 
            // compilePromptText
            // 
            this.compilePromptText.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.compilePromptText.Font = new System.Drawing.Font("Consolas", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.compilePromptText.Location = new System.Drawing.Point(3, 531);
            this.compilePromptText.Multiline = true;
            this.compilePromptText.Name = "compilePromptText";
            this.compilePromptText.ReadOnly = true;
            this.compilePromptText.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.compilePromptText.Size = new System.Drawing.Size(688, 137);
            this.compilePromptText.TabIndex = 3;
            // 
            // HexStreamGroup
            // 
            this.HexStreamGroup.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.HexStreamGroup.Controls.Add(this.tableLayoutPanel4);
            this.HexStreamGroup.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.HexStreamGroup.Location = new System.Drawing.Point(703, 3);
            this.HexStreamGroup.Name = "HexStreamGroup";
            this.HexStreamGroup.Size = new System.Drawing.Size(294, 671);
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
            this.tableLayoutPanel4.Size = new System.Drawing.Size(288, 647);
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
            this.binText.Size = new System.Drawing.Size(282, 481);
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
            this.tableLayoutPanel5.Size = new System.Drawing.Size(282, 44);
            this.tableLayoutPanel5.TabIndex = 0;
            // 
            // saveVerilog
            // 
            this.saveVerilog.Dock = System.Windows.Forms.DockStyle.Fill;
            this.saveVerilog.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.saveVerilog.Location = new System.Drawing.Point(87, 3);
            this.saveVerilog.Name = "saveVerilog";
            this.saveVerilog.Size = new System.Drawing.Size(192, 38);
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
            this.compileBtn.Size = new System.Drawing.Size(78, 38);
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
            this.tableLayoutPanel6.Size = new System.Drawing.Size(282, 44);
            this.tableLayoutPanel6.TabIndex = 1;
            // 
            // programBtn
            // 
            this.programBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.programBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.programBtn.Location = new System.Drawing.Point(191, 3);
            this.programBtn.Name = "programBtn";
            this.programBtn.Size = new System.Drawing.Size(88, 38);
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
            this.portSelectionBox.Size = new System.Drawing.Size(182, 28);
            this.portSelectionBox.TabIndex = 0;
            this.portSelectionBox.DropDown += new System.EventHandler(this.InitializeCurrentPort);
            // 
            // bootAddrGroup
            // 
            this.bootAddrGroup.Controls.Add(this.bootAddrTextBox);
            this.bootAddrGroup.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bootAddrGroup.Location = new System.Drawing.Point(3, 103);
            this.bootAddrGroup.Name = "bootAddrGroup";
            this.bootAddrGroup.Size = new System.Drawing.Size(282, 54);
            this.bootAddrGroup.TabIndex = 6;
            this.bootAddrGroup.TabStop = false;
            this.bootAddrGroup.Text = "boot地址";
            // 
            // bootAddrTextBox
            // 
            this.bootAddrTextBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.bootAddrTextBox.Font = new System.Drawing.Font("宋体", 10.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.bootAddrTextBox.Location = new System.Drawing.Point(3, 21);
            this.bootAddrTextBox.Margin = new System.Windows.Forms.Padding(5);
            this.bootAddrTextBox.Name = "bootAddrTextBox";
            this.bootAddrTextBox.Size = new System.Drawing.Size(276, 28);
            this.bootAddrTextBox.TabIndex = 1;
            this.bootAddrTextBox.Text = "00008000";
            this.bootAddrTextBox.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 3;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 300F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 300F));
            this.tableLayoutPanel1.Controls.Add(this.HexStreamGroup, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel2, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.groupBox1, 2, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 1;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(1300, 677);
            this.tableLayoutPanel1.TabIndex = 6;
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
            this.tableLayoutPanel2.Size = new System.Drawing.Size(694, 671);
            this.tableLayoutPanel2.TabIndex = 6;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.tableLayoutPanel7);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(1003, 3);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(294, 671);
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
            this.tableLayoutPanel7.Size = new System.Drawing.Size(288, 647);
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
            this.userPortTextBox.Size = new System.Drawing.Size(282, 511);
            this.userPortTextBox.TabIndex = 6;
            // 
            // tableLayoutPanel8
            // 
            this.tableLayoutPanel8.ColumnCount = 2;
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 25F));
            this.tableLayoutPanel8.Controls.Add(this.userPortClearBtn, 1, 1);
            this.tableLayoutPanel8.Controls.Add(this.userPortOpenCloseBtn, 1, 0);
            this.tableLayoutPanel8.Controls.Add(this.userPortSelectionBox, 0, 0);
            this.tableLayoutPanel8.Controls.Add(this.userPortShowHex, 0, 1);
            this.tableLayoutPanel8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel8.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel8.Name = "tableLayoutPanel8";
            this.tableLayoutPanel8.RowCount = 2;
            this.tableLayoutPanel8.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel8.Size = new System.Drawing.Size(282, 84);
            this.tableLayoutPanel8.TabIndex = 2;
            // 
            // userPortClearBtn
            // 
            this.userPortClearBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortClearBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.userPortClearBtn.Location = new System.Drawing.Point(191, 45);
            this.userPortClearBtn.Name = "userPortClearBtn";
            this.userPortClearBtn.Size = new System.Drawing.Size(88, 36);
            this.userPortClearBtn.TabIndex = 4;
            this.userPortClearBtn.Text = "清空";
            this.userPortClearBtn.UseVisualStyleBackColor = true;
            this.userPortClearBtn.Click += new System.EventHandler(this.userPortClearBtn_Click);
            // 
            // userPortOpenCloseBtn
            // 
            this.userPortOpenCloseBtn.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortOpenCloseBtn.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.userPortOpenCloseBtn.Location = new System.Drawing.Point(191, 3);
            this.userPortOpenCloseBtn.Name = "userPortOpenCloseBtn";
            this.userPortOpenCloseBtn.Size = new System.Drawing.Size(88, 36);
            this.userPortOpenCloseBtn.TabIndex = 3;
            this.userPortOpenCloseBtn.Text = "打开";
            this.userPortOpenCloseBtn.UseVisualStyleBackColor = true;
            this.userPortOpenCloseBtn.Click += new System.EventHandler(this.userPortOpenCloseBtn_Click);
            // 
            // userPortSelectionBox
            // 
            this.userPortSelectionBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortSelectionBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.userPortSelectionBox.Font = new System.Drawing.Font("宋体", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.userPortSelectionBox.FormattingEnabled = true;
            this.userPortSelectionBox.Location = new System.Drawing.Point(3, 3);
            this.userPortSelectionBox.Name = "userPortSelectionBox";
            this.userPortSelectionBox.Size = new System.Drawing.Size(182, 28);
            this.userPortSelectionBox.TabIndex = 0;
            this.userPortSelectionBox.DropDown += new System.EventHandler(this.InitializeUserPort);
            // 
            // userPortShowHex
            // 
            this.userPortShowHex.AutoSize = true;
            this.userPortShowHex.Dock = System.Windows.Forms.DockStyle.Fill;
            this.userPortShowHex.Location = new System.Drawing.Point(3, 45);
            this.userPortShowHex.Name = "userPortShowHex";
            this.userPortShowHex.Size = new System.Drawing.Size(182, 36);
            this.userPortShowHex.TabIndex = 5;
            this.userPortShowHex.Text = "十六进制显示";
            this.userPortShowHex.UseVisualStyleBackColor = true;
            // 
            // UserPortRecvCountLabel
            // 
            this.UserPortRecvCountLabel.AutoSize = true;
            this.UserPortRecvCountLabel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.UserPortRecvCountLabel.Location = new System.Drawing.Point(3, 610);
            this.UserPortRecvCountLabel.Margin = new System.Windows.Forms.Padding(3);
            this.UserPortRecvCountLabel.Name = "UserPortRecvCountLabel";
            this.UserPortRecvCountLabel.Size = new System.Drawing.Size(282, 34);
            this.UserPortRecvCountLabel.TabIndex = 7;
            this.UserPortRecvCountLabel.Text = "接收: 0 B";
            // 
            // serialPort
            // 
            this.serialPort.BaudRate = 115200;
            this.serialPort.ReadTimeout = 50;
            this.serialPort.WriteTimeout = 300;
            // 
            // UserSerialPort
            // 
            this.UserSerialPort.BaudRate = 115200;
            this.UserSerialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.UserSerialPort_DataReceived);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1300, 677);
            this.Controls.Add(this.tableLayoutPanel1);
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
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel2.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.tableLayoutPanel7.ResumeLayout(false);
            this.tableLayoutPanel7.PerformLayout();
            this.tableLayoutPanel8.ResumeLayout(false);
            this.tableLayoutPanel8.PerformLayout();
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
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
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
        private System.Windows.Forms.ComboBox userPortSelectionBox;
        private System.Windows.Forms.TextBox userPortTextBox;
        private System.Windows.Forms.Button userPortClearBtn;
        private System.Windows.Forms.CheckBox userPortShowHex;
        private System.IO.Ports.SerialPort UserSerialPort;
        private System.Windows.Forms.Label UserPortRecvCountLabel;

    }
}


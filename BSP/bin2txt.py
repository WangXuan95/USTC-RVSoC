import os
import sys
from tkinter import filedialog


def bin文件转换(输入文件, 输出文件, 数据位宽):
    bin文件 = open(输入文件, 'rb')
    文本文件 = open(输出文件, 'w')
    字节索引 = 0
    b0 = 0
    b1 = 0
    b2 = 0
    b3 = 0
    bin文件内容 = bin文件.read(os.path.getsize(输入文件))
    if 数据位宽=='32位':
        for b in  bin文件内容:
            if 字节索引 == 0:
                b0 = b
                字节索引 = 字节索引 + 1
            elif 字节索引 == 1:
                b1 = b
                字节索引 = 字节索引 + 1
            elif 字节索引 == 2:
                b2 = b
                字节索引 = 字节索引 + 1
            elif 字节索引 == 3:
                b3 = b
                字节索引 = 0
                一条指令 = []
                一条指令.append(b3)
                一条指令.append(b2)
                一条指令.append(b1)
                一条指令.append(b0)
                文本文件.write(bytearray(一条指令).hex() + '\n')
    elif 数据位宽=='8位' :
        for b in  bin文件内容:
            文本文件.write('%02x' % b +' ')#str(hex(b)[2:])
    else :
        print('bin转换位宽错误')
    bin文件.close()
    文本文件.close()



##########################################################
if __name__ == '__main__':
    待转换的文件路径=filedialog.askopenfilename()
    if 待转换的文件路径:
        print(待转换的文件路径)
        bin文件转换(待转换的文件路径, 'inst.txt', '32位')
    else :
    	print("空路径，退出")
    sys.exit()
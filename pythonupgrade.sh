echo "请输入序号选择你要干啥:  
输入1. 升级到Python 2.7.9 
输入2. 安装python3.7，并与Python2共存(已经存在不用安装)
输入3. 安装python3.10，并与Python2共存(已经存在不用安装)
输入99. 直接删除python2.7和python3__危险！有可能使Yum将无法使用，知道vi /usr/bin/yum  自便
"  
  
value=0;  
  
read -p "请输入选项: " value  
  
case $value in  
    1) echo "升级python2.7.9"  
sleep 1s
# install some necessary tools & libs
echo "install some necessary tools & libs"
yum -y groupinstall "Development tools"
yum -y install openssl-devel zlib-devel ncurses-devel bzip2-devel readline-devel
yum -y install libtool-ltdl-devel sqlite-devel tk-devel tcl-devel
yum install -y readline readline-devel readline-static
yum install -y openssl openssl-devel openssl-static
yum install -y bzip2-devel bzip2-libs
sleep 5

# download and install python
version='2.7.9'
python_url="https://www.python.org/ftp/python/$version/Python-${version}.tgz"
 
# check current python version
echo "before installation, your python version is: $(python -V &2>1)"
python -V 2>&1 | grep "$version"
if [ $? -eq 0 ]; then
  echo "current version is the same as this installation."
  echo "Quit as no need to install."
  exit 0
fi
 
echo "download/build/install your python"
cd /tmp
wget --no-check-certificate $python_url
tar -zxf Python-${version}.tgz
cd Python-${version}
./configure
make -j 4
make install
sleep 5
 
echo "check your installed python"
python -V 2>&1 | grep "$version"
if [ $? -ne 0 ]; then
  echo "python -V is not your installed version"
  /usr/local/bin/python -V 2>&1 | grep "$version"
  if [ $? -ne 0 ]; then
    echo "installation failed. use '/usr/local/bin/python -V' to have a check"
  fi
  exit 1
fi
sleep 5
 
# install setuptools
echo "安装 setuptools"
wget --no-check-certificate https://bootstrap.pypa.io/ez_setup.py
python ez_setup.py
# check easy_install version
easy_install --version
sleep 5
 
# install pip for the new python
echo "正在用pip安装新的 python"
easy_install pip
# check pip version
pip -V


echo "安装完成"
echo "如果 'python -V' 仍然显示旧版本，可能需要重新运行脚本"
echo "然后/或者在 set /usr/local/bin 设置环境变量"
echo "----------------------------------------------------------------------------------------------------------"
echo "有问题请在   https://cangshui.net/?p=2198  评论区留言，我会尽可能的回复（忙的话就要等很久了呢。。。"
echo "----------------------------------------------------------------------------------------------------------"
 
        ;;  
    2) echo "安装python3.7，(已经存在不用安装)"  
  sleep 1s
yum -y groupinstall 'Development Tools'
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel
sleep 2s
wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0b3.tar.xz
tar Jxvf Python-3.7.0b3.tar.xz
cd Python-3.7.0b3
./configure --prefix=/usr/local/python3
make && make install
echo 'export PATH=$PATH:/usr/local/python3/bin' >> ~/.bashrc
ln -sv /usr/local/python3/bin/python3.7 /usr/bin/python3
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
echo "安装完成"
echo "如果 'python3 -V' 仍然显示旧版本，可能需要重新运行脚本"
echo "然后设置环境变量"
echo "----------------------------------------------------------------------------------------------------------"
echo "有问题请在   https://cangshui.net/?p=2198  评论区留言，我会尽可能的回复（忙的话就要等很久了呢。。。"
echo "----------------------------------------------------------------------------------------------------------"
wget -P /root https://raw.githubusercontent.com/welcomefrank/upgradepython/main/print.py
python3 /root/print.py
rm -rf /root/print.py
        ;; 
    3) echo "安装python3.10，并与Python2共存(已经存在不用安装)"  
  sleep 1s
yum -y groupinstall 'Development Tools'
sudo yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel
sleep 2s
mkdir tmp
cd /tmp
curl https://ftp.openssl.org/source/old/1.1.1/openssl-1.1.1j.tar.gz --output openssl.tar.gz -k
tar xzf openssl.tar.gz
rm -rf openssl.tar.gz
cd openssl-1.1.1j/
./config --prefix=/tmp/openssl && make && make install
echo 'export LD_LIBRARY_PATH=/tmp/openssl/lib' >> ~/.bashrc
echo 'export CFLAGS="-I/tmp/openssl/include"' >> ~/.bashrc
cd
wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar -xf Python-3.10.0.tgz
cd Python-3.10.0
./configure --with-openssl=/tmp/openssl --prefix=/usr/local/python3
make && make install
echo 'export PATH=$PATH:/usr/local/python3/bin' >> ~/.bashrc
ln -sfv /usr/local/python3/bin/python3.10 /usr/bin/python3
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
echo "安装完成"
echo "如果 'python3 -V' 仍然显示旧版本，可能需要重新运行脚本"
echo "然后设置环境变量"
echo "----------------------------------------------------------------------------------------------------------"
echo "有问题请在   https://cangshui.net/?p=2198  评论区留言，我会尽可能的回复（忙的话就要等很久了呢。。。"
echo "----------------------------------------------------------------------------------------------------------"
wget -P /root https://raw.githubusercontent.com/welcomefrank/upgradepython/main/print.py
python3 /root/print.py
rm -rf /root/print.py
        ;;          
   99) echo "卸载！"  
echo "正在卸载，请等待"
rm -rf /usr/local/bin/python2.7
rm -rf /usr/local/bin/python2.7-config
rm -rf /usr/local/lib/python2.7
rm -rf /usr/bin/python3 
rm -rf /usr/local/python3 
rm -rf /usr/local/python3/bin/python3 
rm -rf /usr/local/python3/bin/python3.7 
rm -rf /usr/local/python3/bin/python3.7m-config 
rm -rf /usr/local/python3/bin/python3.7-config 
rm -rf /usr/local/python3/bin/python3.7m
echo "删除完成"
        ;; 
    *) echo "请你输入选项"
        exit 1  
        ;;  
esac

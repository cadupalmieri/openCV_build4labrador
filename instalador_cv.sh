#Script de instalacao do OpenCV com modulos contrib
#by CD

OPENCV_VERSION='3.4.6'   #escolher a versão desejada

echo '=============================================='
echo 'Instalação do pacote OpenCv - '${OPENCV_VERSION}' e modulos'
echo '=============================================='
   
echo '=============================================='
echo 'Limpando residuos de instalacoes anteriores'
echo '=============================================='

sudo rm -rf opencv
sudo rm -rf opencv_contrib

echo '=============================================='
echo 'Atualizando Sistema Operacional'
echo '=============================================='

sudo apt-get -y remove --purge libreoffice*

sudo apt-get -y update
sudo apt-get -y upgrade       
sudo apt-get -y dist-upgrade  
sudo apt-get -y autoremove    


echo '=============================================='
echo 'Instalando pacotes de dependecia'
echo '=============================================='


sudo apt-get install -y build-essential cmake

sudo apt-get install -y qt5-default libvtk6-dev

sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev \
                         libopenexr-dev libgdal-dev

sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev \
                        libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm \
                        libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

sudo apt-get install -y libtbb-dev libeigen3-dev

sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy

sudo apt-get install -y ant default-jdk

sudo apt-get install -y doxygen

sudo apt-get install -y python-setuptools python-pip python-sklearn

sudo pip install imutils

echo '=============================================='
echo 'Baixando pacotes OpenCV e os modulos adicionais'
echo '=============================================='

sudo apt-get install -y unzip wget

wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
mv opencv-${OPENCV_VERSION} opencv

wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
mv opencv_contrib-${OPENCV_VERSION} opencv_contrib

echo '=============================================='
echo 'Criando pasta para compilacao do pacote'
echo '=============================================='

cd opencv 
mkdir build  
cd build

echo '=============================================='
echo 'Gerando lista de confiraçoes para compilacao'
echo '=============================================='

cmake -DWITH_QT=ON\
-DWITH_OPENGL=ON\
-DFORCE_VTK=ON\
-DWITH_TBB=ON\
-DWITH_GDAL=ON\
-DWITH_XINE=ON\
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules\
-DBUILD_EXAMPLES=ON\
-DENABLE_PRECOMPILED_HEADERS=OFF ..

echo '=============================================='
echo 'Iniciando compilacao'
echo '=============================================='

make -j4


echo '=============================================='
echo 'Iniciando Instalacao'
echo '=============================================='

sudo make install
sudo ldconfig

echo '=============================================='
echo 'ACABOU'
echo '=============================================='

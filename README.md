# image_classifier_sample


## 準備

### ▼ Homebrewのインストール

https://brew.sh/index_ja.html

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### ▼ pyenvのインストール

```sh
brew update
brew install pyenv
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

### ▼ anacondaのインストール

```sh
pyenv install --list
pyenv install anaconda2-4.4.0
pyenv versions
```

### ▼ 仮想環境を設定

```sh
# condaコマンドを使うので、一旦globalのversionsをanacondaに
pyenv global anaconda2-4.4.0
conda create -n fruits-classify anaconda
# 必要に応じてglobalの環境を戻す
# pyenv global system

cd /your/workspace
pyenv local anaconda2-4.4.0/envs/fruits-classify
```

### ▼ Keras, Tensorflow, CoreMLToolsのインストール

```sh
# pip install tensorflow==1.1.0
# pip install keras==2.0.4
# pip install coremltools==0.4.0
pip install -r requirements.txt
```

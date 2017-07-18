# image_classifier_sample


## 準備

### ▼ Homebrewのインストール

```sh
# https://brew.sh/index_ja.html
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
pyenv install anaconda3-4.4.0
pyenv versions
```

### ▼ 仮想環境を設定

```sh
# condaコマンドを使うので、一旦globalのversionsをanacondaに
pyenv global anaconda3-4.4.0
conda create -n fruits-classify anaconda
# 必要に応じてglobalの環境を戻す
# pyenv global system

cd /your/workspace
pyenv local anaconda3-4.4.0/envs/fruit-classify
```

### ▼ KerasとTensorflowのインストール

```sh
# pip install tensorflow
# pip install keras
pip install -r requirements.txt
```

### ▼ Core ML Tools のインストール

```sh
mkdir coremltools
cd coremltools
pyenv install anaconda2-4.4.0
pyenv global anaconda2-4.4.0
conda create -n coremltools anaconda
pyenv local anaconda2-4.4.0/envs/coremltools
```
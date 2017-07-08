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

### ▼ pyenv-virtualenvのインストール

```sh
brew update
brew install pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
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
pyenv virtualenv anaconda3-4.4.0 fluits-recognizer
pyenv versions
```




# Adaptive Trader on linux

Start ubuntu (tested on 14.04.3)

### Installation
Move to a folder of your choice that we will name `INSTALL_FOLDER`.  
- The install script will place `adaptiveTrader` and `node` in `INSTALL_FOLDER`. 
- `Crossbar.io` and `eventstore` will be installed globally.  

Install with:
```
curl https://raw.githubusercontent.com/tdeheurles/docs/master/linux/AdaptiveTrader/install.sh > /tmp/install.sh && bash /tmp/install.sh && rm /tmp/install.sh
```

You can control installation with:

```
$ node --version
v5.1.0

$ npm --version
3.3.12

$ dnvm --version
1.0.0-rc2-15545

$ dnvm list

Active Version              Runtime Architecture OperatingSystem Alias
------ -------              ------- ------------ --------------- -----
  *    1.0.0-rc1-final      mono                 linux/osx       default

```


### Start
Start a new Terminal (in order to have PATH updated)
Move to `INSTALL_FOLDER`

Start with:
```
curl https://raw.githubusercontent.com/tdeheurles/docs/master/linux/AdaptiveTrader/start.sh > /tmp/start.sh && bash /tmp/start.sh && rm /tmp/start.sh
```

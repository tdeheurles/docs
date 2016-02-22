# browser-window
### Event: 'close'
### Event: 'closed'
### Event: 'unresponsive'
### Event: 'responsive'
### Event: 'blur'
### Event: 'focus'
### Event: 'maximize'
### Event: 'unmaximize'
### Event: 'minimize'
### Event: 'restore'
### Event: 'resize'
### Event: 'move'
### Event: 'moved'
### Event: 'enter-full-screen'
### Event: 'leave-full-screen'
### Event: 'enter-html-full-screen'
### Event: 'leave-html-full-screen'
### Event: 'devtools-opened'
### Event: 'devtools-closed'
### Event: 'devtools-focused'
### Event: 'app-command':
### Class Method: BrowserWindow.getAllWindows()
### Class Method: BrowserWindow.getFocusedWindow()
### Class Method: BrowserWindow.fromWebContents(webContents)
### Class Method: BrowserWindow.fromId(id)
### Class Method: BrowserWindow.addDevToolsExtension(path)
### Class Method: BrowserWindow.removeDevToolsExtension(name)
### BrowserWindow.webContents
### BrowserWindow.devToolsWebContents
### BrowserWindow.id
### BrowserWindow.destroy()
### BrowserWindow.close()
### BrowserWindow.focus()
### BrowserWindow.isFocused()
### BrowserWindow.show()
### BrowserWindow.showInactive()
### BrowserWindow.hide()
### BrowserWindow.isVisible()
### BrowserWindow.maximize()
### BrowserWindow.unmaximize()
### BrowserWindow.isMaximized()
### BrowserWindow.minimize()
### BrowserWindow.restore()
### BrowserWindow.isMinimized()
### BrowserWindow.setFullScreen(flag)
### BrowserWindow.isFullScreen()
### BrowserWindow.setAspectRatio(aspectRatio[, extraSize])
### BrowserWindow.setBounds(options)
### BrowserWindow.getBounds()
### BrowserWindow.setSize(width, height)
### BrowserWindow.getSize()
### BrowserWindow.setContentSize(width, height)
### BrowserWindow.getContentSize()
### BrowserWindow.setMinimumSize(width, height)
### BrowserWindow.getMinimumSize()
### BrowserWindow.setMaximumSize(width, height)
### BrowserWindow.getMaximumSize()
### BrowserWindow.setResizable(resizable)
### BrowserWindow.isResizable()
### BrowserWindow.setAlwaysOnTop(flag)
### BrowserWindow.isAlwaysOnTop()
### BrowserWindow.center()
### BrowserWindow.setPosition(x, y)
### BrowserWindow.getPosition()
### BrowserWindow.setTitle(title)
### BrowserWindow.getTitle()
### BrowserWindow.flashFrame(flag)
### BrowserWindow.setSkipTaskbar(skip)
### BrowserWindow.setKiosk(flag)
### BrowserWindow.isKiosk()
### BrowserWindow.setRepresentedFilename(filename)
### BrowserWindow.getRepresentedFilename()
### BrowserWindow.setDocumentEdited(edited)
### BrowserWindow.IsDocumentEdited()
### BrowserWindow.openDevTools([options])
### BrowserWindow.closeDevTools()
### BrowserWindow.isDevToolsOpened()
### BrowserWindow.toggleDevTools()
### BrowserWindow.inspectElement(x, y)
### BrowserWindow.inspectServiceWorker()
### BrowserWindow.focusOnWebView()
### BrowserWindow.blurWebView()
### BrowserWindow.capturePage([rect, ]callback)
### BrowserWindow.print([options])
### BrowserWindow.printToPDF(options, callback)
### BrowserWindow.loadUrl(url, [options])
### BrowserWindow.reload()
### BrowserWindow.setMenu(menu)
### BrowserWindow.setProgressBar(progress)
### BrowserWindow.setOverlayIcon(overlay, description)
### BrowserWindow.setThumbarButtons(buttons)
### BrowserWindow.showDefinitionForSelection()
### BrowserWindow.setAutoHideMenuBar(hide)
### BrowserWindow.isMenuBarAutoHide()
### BrowserWindow.setMenuBarVisibility(visible)
### BrowserWindow.isMenuBarVisible()
### BrowserWindow.setVisibleOnAllWorkspaces(visible)
### BrowserWindow.isVisibleOnAllWorkspaces()

## Class: WebContents
### Event: 'did-finish-load'
### Event: 'did-fail-load'
### Event: 'did-frame-finish-load'
### Event: 'did-start-loading'
### Event: 'did-stop-loading'
### Event: 'did-get-response-details'
### Event: 'did-get-redirect-request'
### Event: 'dom-ready'
### Event: 'page-favicon-updated'
### Event: 'new-window'
### Event: 'will-navigate'
### Event: 'crashed'
### Event: 'plugin-crashed'
### Event: 'destroyed'

### WebContents.session
### WebContents.loadUrl(url, [options])
### WebContents.getUrl()
### WebContents.getTitle()
### WebContents.isLoading()
### WebContents.isWaitingForResponse()
### WebContents.stop()
### WebContents.reload()
### WebContents.reloadIgnoringCache()
### WebContents.canGoBack()
### WebContents.canGoForward()
### WebContents.canGoToOffset(offset)
### WebContents.clearHistory()
### WebContents.goBack()
### WebContents.goForward()
### WebContents.goToIndex(index)
### WebContents.goToOffset(offset)
### WebContents.isCrashed()
### WebContents.setUserAgent(userAgent)
### WebContents.getUserAgent()
### WebContents.insertCSS(css)
### WebContents.executeJavaScript(code[, userGesture])
### WebContents.setAudioMuted(muted)
### WebContents.isAudioMuted()
### WebContents.undo()
### WebContents.redo()
### WebContents.cut()
### WebContents.copy()
### WebContents.paste()
### WebContents.pasteAndMatchStyle()
### WebContents.delete()
### WebContents.selectAll()
### WebContents.unselect()
### WebContents.replace(text)
### WebContents.replaceMisspelling(text)
### WebContents.hasServiceWorker(callback)
### WebContents.unregisterServiceWorker(callback)
### WebContents.print([options])
### WebContents.printToPDF(options, callback)
### WebContents.addWorkSpace(path)
### WebContents.removeWorkSpace(path)
### WebContents.send(channel[, args...])

## Class: Session
### Session.cookies
### Session.cookies.get(details, callback)
### Session.cookies.set(details, callback)
### Session.cookies.remove(details, callback)
### Session.clearCache(callback)
### Session.clearStorageData([options, ]callback)
### Session.setProxy(config, callback)
### Session.setDownloadPath(path)
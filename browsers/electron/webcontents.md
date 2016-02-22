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

- `ENOSPC` error
```
events.js:183
[0]       throw er; // Unhandled 'error' event
[0]       ^
[0] 
[0] Error: watch DataTurks/bazaar/bin ENOSPC
[0]     at FSWatcher.start (fs.js:1382:19)
[0]     at Object.fs.watch (fs.js:1408:11)
[0]     at createFsWatchInstance (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:37:15)
[0]     at setFsWatchListener (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:80:15)
[0]     at FSWatcher.NodeFsHandler._watchWithNodeFs (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:228:14)
[0]     at FSWatcher.NodeFsHandler._handleDir (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:407:19)
[0]     at FSWatcher.<anonymous> (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:455:19)
[0]     at FSWatcher.<anonymous> (/home/gokulnc/OFL/DataTurks/bazaar/node_modules/chokidar/lib/nodefs-handler.js:460:16)
[0]     at FSReqWrap.oncomplete (fs.js:153:5)
[0] better-npm-run start-onprem-dev exited with code 1
npm ERR! code ELIFECYCLE
npm ERR! errno 1
```

Solution: https://stackoverflow.com/a/32600959/5002496

- Login session is getting reset often.  
Have to find out why.



Q：在注册页面显示弹窗如下：
Request has been terminated Possible causes: the network is offline, Origin is not allowed by Access-Control-Allow-Origin, the page is being unloaded, etc.
A：您需要将端口80添加到附加到托管DataTurks的ec2实例的安全组的入站规则。
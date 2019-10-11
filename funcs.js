function init(){
    uBusy.running=true
    console.log('Init...')

    var appArgs=Qt.application.arguments
    console.log('AppArgs: '+appArgs)
    if(appArgs.indexOf('-resetUseId')>=0){
        appSettings.userId=''
    }

    if(appArgs.indexOf('-dev')>=0){
        //appSettings.userId=app.adminId
        app.host0='http://192.168.1.46:8080'
        app.host1='http://192.168.1.46:8081'
        console.log('Urls definidas desde -dev: host0: '+app.host0+' host1: '+app.host1)
        uBusy.running=false
        getGlobalDataObject()
        return
    }
    var r1=''
    var r2=''
    callHttp(appSettings.host0, function (res1){
        r1=res1;
        console.log('Result checking host0: '+appSettings.host0+' res: '+res1)
        callHttp(appSettings.host1+'/init', function (res2){
            r2=res2;
            console.log('Result checking host1: '+appSettings.host1+' res: '+res2)
            console.log('r1: '+r1)
            console.log('r2: '+r2)
            if(res2===0||r1==='404'||r2==='404'||res1.indexOf('502 Bad Gateway')>0||res2.indexOf('502 Bad Gateway')>0||res1.indexOf('<title>Error</title>')>0||res2.indexOf('<title>Error</title>')>0){
                console.log('Fallo en urls por defecto...')
                let url = 'https://nextsigner.github.io/eficina/servers/'+appSettings.eficina+'?r='+ms()
                callHttp(url, function (res3){
                    var m0=res3.replace(/\n/g, '').split('|');
                    if(m0.length>=2){
                        app.host0=m0[0]
                        app.host1=m0[1]
                        appSettings.host0=app.host0
                        appSettings.host1=app.host1
                        console.log('Urls definidas desde github: host0: '+app.host0+' host1: '+app.host1)
                        uBusy.running=false
                        getGlobalDataObject()
                    }else{
                        console.log('Error! Ninguna url funciona!')
                    }
                })
            }else{
                console.log('The url from setted are active.')
                app.host0=appSettings.host0
                app.host1=appSettings.host1
                uBusy.running=false
                getGlobalDataObject()
            }
        })
    })
}

function getGlobalDataObject(){
    var url=app.host0+'/eficina/get/globalData'
    console.log('Geting global data from '+url)
    tTimeOutInit.start()
    callHttp(url, function (res){
        console.log('geting global data res:'+res)
        if(res===0||res==='404'||res.indexOf('502 Bad Gateway')>=0){
            console.log('Error Geting global data:'+res)
        }else{
            tTimeOutInit.stop()
            app.gd=JSON.parse(res)
            //console.log('Global data: '+res)
            //console.log('Global data id: '+app.gd["adminMainId"])
            //console.log('Global data eficinaName: '+app.gd["eficinaName"])
        }
        xApp.load();
    })
}

function callHttp(url, func){
    var module = {
        retFunc: func
    }
    var r = new Date()
    var req = new XMLHttpRequest();
    req.open("GET", url);
    req.onreadystatechange = function() {
        //console.log('req.onreadystatechange: '+req.readyState);
        if (req.readyState === XMLHttpRequest.DONE) {
            //console.log('logiteca: '+req.responseText);
            return module.retFunc(req.responseText);
        }
    }
    req.onerror = function(){
        console.log(req.status)
        return module.retFunc(req.status);
    }
    req.send();
}

function setData(obj, url){
    var req = new XMLHttpRequest();
    req.open("GET", url);
    req.onreadystatechange = function() {
        if (req.readyState == XMLHttpRequest.DONE) {
            obj.setData(req.responseText);
        }
    }
    req.onerror = function(){
        obj.error(req.status)
    }
    req.send();
}

function getUrl(url){
    var r = new Date()
    var req = new XMLHttpRequest();
    //console.log('logiteca: getting url '+url);
    req.open("GET", url);
    req.onreadystatechange = function() {
        if (req.readyState === XMLHttpRequest.DONE) {
            //console.log('logiteca: '+req.responseText);
            return req.responseText;
        }
    }
    req.onerror = function(){
        console.log(req.status)
        return req.status;
    }
    req.send();
}

function setJSON(obj, url){
    var r = new Date()
    var req = new XMLHttpRequest();
    req.open("POST", url+"?id="+appSettings.userId+"&r="+r.getTime());
    req.onreadystatechange = function() {
        if (req.readyState == XMLHttpRequest.DONE) {
            obj.setJSON(req.responseText);
        }
    }
    req.onerror = function(){
        obj.error(req.status)
    }
    req.send();
}

function ms(){
    let d = new Date(Date.now())
    return d.getTime()
}

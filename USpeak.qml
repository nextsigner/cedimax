import QtQuick 2.0
import unik.UnikQProcess 1.0
Item {
    id: r
    property bool speaking: false
    //property string text: ''
    property var textList: []

    property int currentIndex: 0

    onTextListChanged: {
        if(!r.speaking){
            play()
        }
    }
    function add(text){
        r.textList.push(text)
    }
    function play(){
        speak(r.textList[r.currentIndex], r.currentIndex)
    }
    function next(){
        if(r.currentIndex<textList.length-1)r.currentIndex++
        speak(r.textList[r.currentIndex], r.currentIndex)
    }
    function speak(text, index){
        var t=text.replace(/\n/g, '     ')
        var c='import QtQuick 2.0
import unik.UnikQProcess 1.0
    UnikQProcess{
        id:uqp
        property int index: '+index+'\n
        onLogDataChanged: {
            if(logData.indexOf(\'unikqprocess::speak::ended\')>=0){
                if(uqp.index===r.textList.length-1){
                    r.speaking=false
                }
                uqp.destroy(500)
            }
        }
    Component.onCompleted: {
        let vbs =\'Dim speaks, speech, voice\r\n\'
        vbs+=\'Set speech=CreateObject("sapi.spvoice")\r\n\'
        vbs+=\'speaks=\"'+t+'\"\r\n\'
        vbs+=\'speech.Speak speaks\r\n\'
        vbs+=\'WScript.Echo "unikqprocess::speak::ended"\r\n\'
        vbs+=\'\r\n\'
        let d = new Date(Date.now())
        let vbsFileName=unik.getPath(2)+\'/\'+d.getTime()+\'.vbs\'
        unik.setFile(vbsFileName, vbs, "ANSI")
        run(\'cmd /c cscript \'+vbsFileName)
        r.speaking=true
    }
}
'
        var comp = Qt.createQmlObject(c, r, 'speak')
    }
    Component.onCompleted: {
        if(r.text!==''){
            //speak(r.text)
        }
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import QtMultimedia 5.12
import "funcs.js" as JS

ApplicationWindow {
    id: app
    visible: true
    visibility: Qt.platform.os==='android'?'FullScreen':'Windowed'
    width: Qt.platform.os==='linux'?480:Screen.width
    height: Qt.platform.os==='linux'?680:Screen.height
    property string moduleName: appSettings.moduleName
    property int fs: Qt.application.font.pixelSize
    property string fontFamily: 'Arial Black'

    property bool anonimo: true

    property var gd: ({}) //Global Object Data

    property string host0
    property string host1

    property string nui

    FontLoader{name:"FontAwesome"; source: "qrc:/fontawesome-webfont.ttf"}
    Settings{
        id: appSettings
        category: 'conf-'+app.moduleName
        property string eficina
        property string host0
        property string host1
        property string moduleName
        property string userId
        property string uAdminEmail
        property string uMoreInfoUrl
    }
    X0{
        id:xApp
        anchors.fill: parent
        property int currentIndex: 0
        onCurrentIndexChanged: {
            console.log('CI: '+currentIndex)
            /*for(var i=0;i<xApp.children.length;i++){
                if(i!==currentIndex){
                        xApp.children[i].visible=false
                }else{
                    xApp.children[i].visible=true
                }
            }*/
        }
        function load(){
            var d = new Date(Date.now())
            JS.callHttp(app.host1+'/XApp.qml?r='+d.getTime(), function (res){
                //console.log('Splash code: '+res)
                if(res!=='404'&&res!==''){
                    var obj = Qt.createQmlObject(res, xApp, 'xApp')
                }else{
                    xInfo1.visible=true
                }
            })
        }
          }
    Rectangle{
        id: xInfo1
        width: xApp.width*0.8
        height: txtInfo1.contentHeight+btnReintentar.height*2+app.fs*2
        border.width: 1
        radius: app.fs*0.5
        anchors.centerIn: parent
        visible: false
        Column{
            width: parent.width
            spacing: app.fs*0.5
            anchors.centerIn: parent
            Text {
                id: txtInfo1
                width: parent.width-app.fs
                text: qsTr('En estos momentos el sistema <b>Eficina</b> no se encuentra disponible.<br />Es posible que su aplicación no esté configurada correctamente o el administrador de la eficina a la que usted pretende acceder no esté funcionando en este momento.<br /><br />Para màs informaciòn envìa un email a '+(appSettings.uAdminEmail===''?'nextsigner@gmail.com':appSettings.uAdminEmail))
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button{
                id: btnMasInfo1
                text: 'Mas Informaciòn'
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    xInfo1.visible=false
                    var d=new Date(Date.now())
                    JS.setData(x0, (appSettings.uMoreInfoUrl===''?'https://raw.githubusercontent.com/nextsigner/nextsigner.github.io/master/eficina/MasInfo1.qml?r=':appSettings.uMoreInfoUrl)+d.getTime());
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Button{
                    id: btnReintentar
                    text: 'Reintentar'
                    onClicked: {
                        xInfo1.visible=false
                        JS.init()
                    }
                }
                Button{
                    id: btnSalir1
                    text: 'Salir/Apagar'
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }
    }
    Rectangle{
        id: xInfo2
        width: xApp.width*0.8
        height: txtInfo2.contentHeight+btnReintentar2.height*2+app.fs*2
        border.width: 1
        radius: app.fs*0.5
        anchors.centerIn: parent
        visible: false
        Column{
            width: parent.width
            spacing: app.fs*0.5
            anchors.centerIn: parent
            Text {
                id: txtInfo2
                width: parent.width-app.fs
                text: qsTr('El sistema <b>Eficina</b> està demorando mucho en responder. <br />Es posible que la conexiòn a internet estè funcionando muy lenta.<br />Es posible que su aplicación no esté configurada correctamente o el administrador de la eficina a la que usted pretende acceder no esté funcionando en este momento.<br /><br />Para màs informaciòn envìa un email a nextsigner@gmail.com')
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Button{
                id: btnMasInfo2
                text: 'Continuar'
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    xInfo2.visible=false
                }
            }
            Row{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Button{
                    id: btnReintentar2
                    text: 'Reintentar'
                    onClicked: {
                        xInfo1.visible=false
                        JS.init()
                    }
                }
                Button{
                    id: btnSalir2
                    text: 'Salir/Apagar'
                    onClicked: {
                        Qt.quit()
                    }
                }
            }
        }
    }
    UBusy{id:uBusy; width: app.fs*3;}





    footer: TabBar {
        id: tabBar
        property int al
        currentIndex: xApp.currentIndex
        Behavior on height {NumberAnimation{duration: 350; easing.type: Easing.InSine}}
        onCurrentIndexChanged: {
            xApp.currentIndex=currentIndex

        }
        Component.onCompleted: al=height
    }
    Audio {
        id: appBeep
        source: "qrc:/resources/beep.wav"
        volume:0.5
    }
    function beep(){
        appBeep.play()
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Timer{
        id: tTimeOut
        running: false
        repeat: false
        interval: 15*1000
        onTriggered: {
            console.log('TimeOut!')
            xInfo1.visible=false
            xInfo2.visible=true
        }
    }
    Timer{
        id: tTimeOutInit
        running: false
        repeat: false
        interval: 15*1000
        onTriggered: {
            console.log('TimeOutInit!')
            xInfo2.visible=false
            xInfo1.visible=true
        }
    }
    Component.onCompleted: {
        tabBar.addItem('aaaa')
        if(appSettings.eficina===''){
            appSettings.eficina='cedimax'
        }
        JS.init()
    }
}

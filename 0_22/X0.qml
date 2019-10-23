import QtQuick 2.12
import QtQuick.Controls 2.12
import QtWebEngine 1.4
Item {
    id: r
    anchors.fill: parent
    property string moduleName: 'Lista de Radios'
    WebEngineView{
        id: wv
        anchors.fill:r
        url: 'https://ar.radiocut.fm/radiostation/am750/listen/'
    }
    MouseArea{
        anchors.fill: r
        onClicked: {
            wv.runJavaScript('document.innerHtml="hola a todos"', function(result) { console.log(result); });
        }
    }
    Component.onCompleted: {
        unik.speak('Se ha cargado el módulo '+r.moduleName, -1)
    }
}

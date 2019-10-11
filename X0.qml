import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: r
    anchors.fill: parent
    property string qml: 'x00'
    signal loaded

    function setData(d){
        var obj = Qt.createQmlObject(d, r, r.qml)
        //console.log(d)
    }
    function error(d){

    }
}

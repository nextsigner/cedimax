import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
Item {
    id: r
    property alias running: b.running
    property int msSpeed: 2000
    visible: opacity>0.1
    width: app.fs*4
    height: width
    anchors.centerIn: parent
    opacity: running?1.0:0.0
    Behavior on opacity{
        NumberAnimation{duration: 250}
    }
    BusyIndicator {
        id:b
        width: r.width
        height: r.width
        style: BusyIndicatorStyle {
            indicator: Item {
                id:bi
                //visible: control.running
                width: r.width
                height: r.width
                //border.width: 2
                MouseArea{
                    anchors.fill: parent
                    onClicked: r.running=!r.running
                }
                Text {
                    id: e1
                    text: '\uf013'
                    font.family: 'FontAwesome'
                    font.pixelSize: parent.width*0.8
                    anchors.left: parent.left
                    anchors.leftMargin: 0-parent.width*0.1
                    Rectangle{
                        width: parent.width*0.4
                        height: width
                        radius: width*0.5
                        anchors.centerIn: parent
                    }
                    RotationAnimator on rotation {
                        running: control.running
                        loops: Animation.Infinite
                        duration: r.msSpeed
                        from: 0 ; to: 360
                    }
                }
                Text {
                    id: e2
                    text: '\uf013'
                    font.family: 'FontAwesome'
                    font.pixelSize: parent.width*0.8
                    anchors.horizontalCenter: e1.horizontalCenter
                    anchors.horizontalCenterOffset: parent.width*0.5
                    anchors.top: parent.top
                    anchors.topMargin: parent.width*0.35
                    Text {
                        id: e3
                        text: '\uf013'
                        font.family: 'FontAwesome'
                        font.pixelSize: parent.width*0.65
                        anchors.centerIn: parent
                        color: 'white'
                        Rectangle{
                            width: parent.width*0.4
                            height: width
                            radius: width*0.5
                            color: 'black'
                            anchors.centerIn: parent
                        }
                    }

                    RotationAnimator on rotation {
                        running: control.running
                        loops: Animation.Infinite
                        duration: r.msSpeed
                        from: 0 ; to: -360
                    }
                }
                Text {
                    id: e4
                    text: '\uf013'
                    font.family: 'FontAwesome'
                    font.pixelSize: e3.font.pixelSize
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset:  parent.width*0.535-parent.width*0.1
                    anchors.verticalCenterOffset: 0-parent.width*0.045
                    color: 'black'
                    Rectangle{
                        width: parent.width*0.4
                        height: width
                        radius: width*0.5
                        anchors.centerIn: parent
                    }
                    RotationAnimator on rotation {
                        running: control.running
                        loops: Animation.Infinite
                        duration: r.msSpeed
                        from: 0 ; to: 360
                    }
                }
            }
        }
    }
}

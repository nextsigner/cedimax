import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.0
import unik.UnikQProcess 1.0

ApplicationWindow {
    id: app
    visible: true
    visibility: 'Maximized'


    Settings{
        id: as
        category: 'conf-cedimax'
        property string mod
        Component.onCompleted: {
            if(mod==='')mod='0-0'
        }
    }
    Matrix{id:matrix}
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Up'
        onActivated: matrix.arriba()
    }
    Shortcut{
        sequence: 'Down'
        onActivated: matrix.abajo()
    }
    Shortcut{
        sequence: 'Left'
        onActivated: matrix.izquierda()
    }
    Shortcut{
        sequence: 'Right'
        onActivated: matrix.derecha()
    }
    USpeak{
        id: uspeak
    }    
    Component.onCompleted: {
        let m0=as.mod.split('-')
        uspeak.add('Cedimax ha iniciado.')
        uspeak.add('Cargando el modulo '+m0[0]+' '+m0[1])
        uspeak.play()
    }
}

import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    id: r
    property string moduleName: 'origen'
    Component.onCompleted: {
        unik.speak('Se ha cargado el módulo '+r.moduleName)
    }
}

import QtQuick 2.0
Item {
    id: r
    anchors.fill: parent
    property int currentX: 0
    property int currentY: 0
    property string uDir: ''


    function arriba(){
            uDir='arriba'
            tDesplazo.cant++
            tDesplazo.dir='hacia arriba'
            tDesplazo.restart()
    }
    function abajo(){
             uDir='abajo'
            tDesplazo.cant++
            tDesplazo.dir='hacia abajo'
            tDesplazo.restart()
    }
    function izquierda(){
             uDir='izquierda'
            tDesplazo.cant++
            tDesplazo.dir='hacia la izquierda'
            tDesplazo.restart()
    }
    function derecha(){
             uDir='derecha'
            tDesplazo.cant++
            tDesplazo.dir='hacia la derecha'
            tDesplazo.restart()
    }
    function cargarModulo(){

    }
    function buscarModulo(){
        if(uDir==='arriba'){
            proximoExistente('arriba')
            uspeak.speak('Buscando habia arriba', -1)

        }
        if(uDir==='abajo'){

        }
        if(uDir==='izquierda'){

        }
        if(uDir==='derecha'){

        }
        //uspeak.speak('Módulo actual '+r.currentX+' '+r.currentY, -1)
    }
    function proximoExistente(sentido){
        if(sentido==='arriba'){
            for(let i=r.currentY-1;i>r.currentY-100;i--){
                let folderName='./'+currentX+'_'+i
                console.log('folderName: '+folderName)
                if(unik.folderExist(folderName)){
                    uspeak.speak('carpeta existente '+currentX+' '+i, -1)
                    break
                }else{
                    console.log('iiiiiiiiiiiiii: '+i)
                }
            }

        }
    }
    property bool cargado: false
    Timer{
        id: tDesplazo
        running: false
        repeat: false
        interval: 1000
        property int cant: 0
        property string dir: ''
        onTriggered: {
            uspeak.speak('Llendo '+cant+' areas '+dir, -1)
            cant=0
            tbuscarModulo.start()
        }
    }
    Timer{
        id: tbuscarModulo
        running: false
        repeat: false
        interval: 500
        onTriggered: {
            buscarModulo()
        }
    }
    Timer{
        id: tCargarModulo
        running: false
        repeat: false
        interval: 1000
        onTriggered: {
            cargarModulo()
        }
    }
    Component.onCompleted: {
        //if(cargado)return
        //cargado=true
        //console.log('modulo '+m0[0]+' '+m0[1])
    }
}

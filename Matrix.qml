import QtQuick 2.0
Item {
    id: r
    anchors.fill: parent
    property int currentX: 0
    property int currentY: 0
    property string currentAreaName: ''

    //Variables de Desplazamiento
    property string currentDespAreaName: ''
    property string currentDespFolderName: ''

    property string uDir: ''
    Text {
        id: log
        text: 'X: '+r.currentX+' Y: '+r.currentY
        font.pixelSize: 30
        color: 'red'
    }
    Item{
        id:xAreas
        anchors.fill: r
    }

    function arriba(){
        r.uDir='arriba'
        r.cant++
        tDesplazo.text='Llendo '+r.cant+' hacia arriba. '
        tDesplazo.restart()
    }
    function abajo(){
        r.uDir='abajo'
        r.cant++
        tDesplazo.text='Llendo '+r.cant+' hacia abajo. '
        tDesplazo.restart()
    }
    function izquierda(){
        r.uDir='izquierda'
        r.cant++
        tDesplazo.text='Llendo '+r.cant+' hacia la izquierda. '
        tDesplazo.restart()
    }
    function derecha(){
        r.uDir='derecha'
        r.cant++
        tDesplazo.text='Llendo '+r.cant+' hacia la derecha. '
        tDesplazo.restart()
    }
    function entrar(){
        tDesplazo.text='Entrando a '+r.currentDespAreaName+'. '
        tDesplazo.restart()
        let c=unik.getFile(r.currentDespFolderName+'/X0.qml')
        var comp = Qt.createQmlObject(c, xAreas, 'x0')
    }
    function cargarModulo(){

    }
    function buscarModulo(sentido, cant){
        tDesplazo.text+=sentido.indexOf('b')>=0?'Buscando area hacia '+sentido+'. ':'Buscando area hacia la '+sentido+'. '
        if(sentido==='arriba'){
            proximoExistente(sentido, cant)
        }
        if(sentido==='abajo'){
            proximoExistente(sentido, cant)
        }
        if(sentido==='izquierda'){

        }
        if(sentido==='derecha'){

        }
        //uspeak.speak('Módulo actual '+r.currentX+' '+r.currentY, -1)
    }
    function proximoExistente(sentido, cant){
        if(sentido==='arriba'){
            for(let i=r.currentY+1;i<r.currentY+100;i++){
                var folderName=unik.currentFolderPath()+'/'+currentX+'_'+i
                console.log('folderName: '+folderName)
                if(unik.folderExist(folderName)){
                    tDesplazo.text+='carpeta existente '+currentX+' '+i+'. '
                    let pn=retPackageData(folderName, "name")
                    tDesplazo.text+='Estamos en el area '+pn+'. Presionar Intro para ingresar a '+pn
                    r.currentDespAreaName=pn
                    r.currentDespFolderName=folderName
                    r.currentY=i
                    break
                }else{
                    console.log('iiiiiiiiiiiiii: '+i)
                }
            }
        }
        if(sentido==='abajo'){
            for(let i=r.currentY-1;i>r.currentY-100;i--){
                let folderName=unik.currentFolderPath()+'/'+currentX+'_'+i
                console.log('folderName: '+folderName)
                if(unik.folderExist(folderName)){
                    tDesplazo.text+='carpeta existente '+currentX+' '+i+'. '
                    let pn=retPackageData(folderName, "name")
                    tDesplazo.text+='Estamos en el area '+pn+'. Presionar Intro para ingresar a '+pn
                    r.currentDespAreaName=pn
                    r.currentDespFolderName=folderName
                    r.currentY=i
                    break
                }else{
                    console.log('iiiiiiiiiiiiii: '+i)
                }
            }
        }
    }
    function retPackageData(folder, item){
        let jfd=unik.getFile(folder+'/package.json')
        //console.log('JSFD: '+jfd)
        let j = JSON.parse(jfd)
        let d = j.description[item]
        return d
        //console.log('JSON: '+JSON.stringify(j))
    }

    property bool cargado: false
    property int cant: 0
    Timer{
        id: tDesplazo
        running: false
        repeat: false
        interval: 1000
        property string text: ''
        onTriggered: {
            buscarModulo(r.uDir, r.cant)
            uspeak.speak(text, -1)
            r.cant=0

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

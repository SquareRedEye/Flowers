import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
Column{
    spacing:30
    property string headName // "Новый", "собранный" или "завершённый"
    property color headColor
    property int currentPosition // Новый, собранный или завершённый
    function refreshList(){
        _list.model = 0
        _list.model = _class.getPackSize(currentPosition)
    }

    Rectangle{
        width:_page.width*0.3
        height: 60
        color: headColor
        Text {
            id: name
            text: headName
            anchors{
                left: parent.left
                leftMargin: 30
                verticalCenter: parent.verticalCenter
            }
            
            font{
                pointSize: _aliases.fontSize2
            }
        }
    }
    ListView{
        id: _list
        model: _class.getPackSize(currentPosition)
        width: _page.width*0.3
        height: 400
        clip: true
        spacing: 15
        delegate:
            Button{
            //visible: _class.checkPosition(modelData, currentPosition)
            width: _page.width*0.25
            height: visible? 200 : 0
            padding: 0
            onReleased: {
                _orderDetail.currentModel = modelData
                _orderDetail.currentPosition = currentPosition
                _orderDetail.refreshList()
                _orderDetail.visible = true
            }
            contentItem:
                Rectangle{
                color:"white"
                Text {
                    anchors{
                        left: parent.left
                        top: parent.top
                        margins: 30
                    }
                    font{
                        pointSize: _aliases.fontSize2
                    }
                    
                    text: _class.getPackInfo(modelData, currentPosition)//_class.getPackTime(modelData) + '\n\n' + _class.getPackPrice(modelData) + "р"
                }
                // УДАЛИТЬ ЗАКАЗ
                Button{
                    id: _delButton
                    height: 50
                    width: 50
                    anchors{
                        right: parent.right
                        bottom: parent.bottom
                        margins: 15
                    }
                    contentItem: Image{
                        source: "qrc:/Images/delete.png"
                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: "white"
                        }
                        
                    }
                    background: Rectangle{
                        color: "green"
                        radius: 5
                    }
                    onReleased: {
                        _class.deletePack(modelData, currentPosition)
                        refreshList()
                    }

                }
            }
        }
    }
}

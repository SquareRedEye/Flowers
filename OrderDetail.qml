import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Page{
    property int currentModel // номер заказа, для которого открыта данная страница
    property int currentPosition // Новый, собранный или завершённый
    Item {
        id: _aliases
        property int fontSize1: 14
        property int fontSize2: 12
        property int fontSize3: 10
        property variant data: ["Детали заказа", "Бюджет", "Комментарий", "Дата"]
    }
    function refreshList()
    {
        _list.text = _class.getOrderList(currentModel, currentPosition)
    }

    id:_page
    visible:true
    anchors{
        fill: parent
        margins: 50
    }
    Text {
        text: qsTr("Свернуть")
        anchors{
            left: parent.left
            top: parent.top
            margins: 20
        }
        font{
            pointSize: _aliases.fontSize2
        }
        MouseArea{
            anchors.fill: parent
            onReleased: _page.visible = false
        }
    }
    Text {
        id:_title
        text: qsTr("Заказ")
        anchors{
            left: parent.left
            top: parent.top
            leftMargin: 20
            topMargin: 60
        }
        font{
            pointSize: _aliases.fontSize1
            bold: true
        }
    }
    Row{
        anchors{
            right: parent.right
            rightMargin: 20
            verticalCenter: _title.verticalCenter
        }
        spacing: 20
        Button{
            text: "Новый"
            background: Rectangle{color: "blue"}
            horizontalPadding: 60
            verticalPadding: 10
            contentItem:Text {
                text: parent.text
                font{
                    pointSize: _aliases.fontSize2
                }
            }
            onReleased: {
                _class.setPackPosition(currentModel, currentPosition, 0)
                _calendar.refreshPackages()
                _page.visible = false;
            }
        }
        Button{
            text: "Собранный"
            background: Rectangle{color: "green"}
            horizontalPadding: 60
            verticalPadding: 10
            contentItem:Text {
                text: parent.text
                font{
                    pointSize: _aliases.fontSize2
                }
            }
            onReleased: {
                _class.setPackPosition(currentModel, currentPosition, 1)
                _calendar.refreshPackages()
                _page.visible = false;
            }
        }
    }
    Column{
        id: _body
        anchors{
            top: _title.bottom
            topMargin: 40
        }
        width: parent.width
        leftPadding: 20
        rightPadding: leftPadding
        spacing: 20
        Repeater{
            model: 4
            Column{
                width: _body.width
                spacing: 10
                Text {
                    text: _aliases.data[modelData]
                    font{
                        pointSize: _aliases.fontSize2
                        bold: modelData == 0? true : false
                    }
                }
                Rectangle{
                    height: modelData == 0? 2 : 1
                    width: _body.width - _body.leftPadding*2
                    color: "black"
                }
            }
        }
    }
    Text {
        id: _title2
        text: qsTr("Чек")
        anchors{
            top:_body.bottom
            left: parent.left
            leftMargin: 20
            topMargin: 20
        }
        font{
            pointSize: _aliases.fontSize2
            bold: true
        }
    }
    ScrollView{
        width: parent.width
        height: 100
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        anchors{
            top:_title2.bottom
            left: parent.left
            leftMargin: 20
            topMargin: 10
        }
        // Чек
        TextArea{
            id: _list
            padding: 0
            text: "чек пуст"
            height: parent.height
            font{
                pointSize: _aliases.fontSize3
            }
        }
    }
    Button{
        text: "Завершить"
        background: Rectangle{color: "red"}
        horizontalPadding: 60
        verticalPadding: 10
        anchors{
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }
        onReleased: {
            _class.setPackPosition(currentModel, currentPosition, 2)
            _calendar.refreshPackages()
            _page.visible = false;
        }

        contentItem:Text {
            text: parent.text
            font{
                pointSize: _aliases.fontSize2
            }
        }
    }
}

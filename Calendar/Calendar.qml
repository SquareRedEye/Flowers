import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Page{
    id:_page
    enabled: !_orderDetail.visible
    background: Rectangle{color:"lightgray"}
    Item {
        id: _aliases
        property int fontSize1: 16
        property int fontSize2: 12
        property variant items: ["Новые", "Собранные", "Завершённые"]
        property variant itemsColor: ["blue", "green", "red"]
    }
    function refreshPackages()
    {
        _packages.model = 0
        _packages.model = 3
    }

    header:
        Rectangle
    {
        color: "pink"
        height: 80
        width: parent.width
        Text {
            text: qsTr("Календарь заказов")
            color: "white"
            anchors{
                left: parent.left
                leftMargin: 60
                verticalCenter: parent.verticalCenter
            }
            font
            {
                pointSize: _aliases.fontSize1
                capitalization: Font.AllUppercase
            }
        }
        Button{
            width: _page.width * 1/4
            height: 60
            anchors{
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 30
            }
            contentItem: Text {
                text: qsTr("Вернуться на главную")
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font{
                    pointSize: _aliases.fontSize2
                    bold: true
                }
            }
            background: Rectangle{
                color: "green"
                radius: 5
            }
            onReleased: _stack.pop()
        }
    }
    Row
    {
        anchors{
            top: parent.top
            topMargin: 60
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 30

        Repeater{
            id: _packages
            model: 3

            List {
                headName: _aliases.items[modelData]
                headColor: _aliases.itemsColor[modelData]
                currentPosition: modelData
            }
        }
    }

}

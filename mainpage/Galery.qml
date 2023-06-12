import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Page{
    id: _page
    height: parent.height
    width: parent.width*2/3
    background:Rectangle{color: "white"}
    Item {
        id: _aliases
        property int spc: _page.width*0.1/4 // отступы
        property int blockWidth: _page.width * 0.3
        property int blockHeight: blockWidth * 2/3
        property int fontSize1: 14
        property int fontSize2: fontSize1*0.8
    }
    header:
        Rectangle
    {
        color: "black"
        width: parent.width
        height: 80
        Image
        {
            anchors{
                left: parent.left
                leftMargin: 103
                verticalCenter: parent.verticalCenter
            }
            source: "qrc:/Images/logo.png"
        }
    }
    Column{
        anchors{
            horizontalCenter: parent.horizontalCenter
        }
        spacing: _aliases.spc
        padding: _aliases.spc
        Text {
            id: _title
            text: qsTr("Ассортимент")
            font{
                pointSize: _aliases.fontSize1
            }
        }
        Column{
            Row
            {
                Image{
                    source: "qrc:/Images/search.png"
                    height: _textField.height
                    width: height
                }
                TextField{
                    id: _textField
                    width: 300
                    focus: false
                    placeholderText: "Название цветка"
                    font{
                        pointSize: _aliases.fontSize2
                    }
                    background:
                        Rectangle {
                        color: "white"
                    }
                }
            }
            Rectangle{
                height: 1
                width: _aliases.blockWidth*3 + _aliases.spc*2
                color: "black"
            }

        }

        ScrollView{
            height: _page.height*2/3
            clip: true
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
            Grid{
                anchors{
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: _aliases.spc
                columns: 3
                Repeater
                {
                    id: _galery
                    model: _class.getSize()
                    Image
                    {
                        visible:
                            if(_textField.text == "") true
                        else if(_textField.text === _class.getName(modelData)) true
                        else false
                        height: _aliases.blockHeight
                        width: _aliases.blockWidth
                        source: "file:///"+_class.getPath(modelData)


                        Label{
                            width: parent.width
                            height: 20
                            leftPadding: 20
                            background: Rectangle{color: "lightgray"; opacity: 0.7}
                            text:_class.getName(modelData) + ":  " + _class.getPrice(modelData)

                            anchors{
                                bottom: parent.bottom
                            }
                            font{
                                pointSize: _aliases.fontSize2
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onReleased:{
                                _class.setOrder(modelData)
                                _bucket.refreshOrder()
                            }
                        }
                    }
                }
            }
        }
    }
}

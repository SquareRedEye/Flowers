import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
Page{
    id: _page
    height: parent.height
    width: parent.width*1/3
    background:Rectangle{color: "white"}

    function refreshOrder()
    {
        _orderList.model = 0
        _orderList.model = _class.getOrderSize()
        _controlSum.text = countSum()
    }
    function countSum() // сумма заказа
    {
        var sum = 0;
        for(var i = 0; i < _class.getOrderSize(); i++)
            sum+=_class.getOrderPrice(i)
        return sum;
    }

    Item {
        id: _aliases
        property int fontSize1: 16
        property int fontSize2: 12
        property int fontSize3: 12
        property int spc: _page.width*0.05
    }
    header:
        Rectangle
    {
        color: "pink"
        height: 80
        width: parent.width
        Text {
            text: qsTr("Сборка букета")
            color: "white"
            anchors{
                left: parent.left
                leftMargin: _aliases.spc*2
                verticalCenter: parent.verticalCenter
            }

            font
            {
                pointSize: _aliases.fontSize1
                capitalization: Font.AllUppercase
            }
        }
    }

    ListView{
        id: _orderList
        height: parent.height
        width: parent.width
        clip: true
        spacing: 10
        model: 0
        delegate: Rectangle
        {
            width: _page.width
            height: width*0.3
            color: "gray"
            Text {
                id: _flowerName
                text: _class.getOrderName(modelData)
                anchors{
                    left: parent.left
                    top: parent.top
                    margins: _aliases.spc
                }
                font{
                    pointSize: _aliases.fontSize2
                }
            }
            Text {
                id: _price
                text: _class.getOrderPrice(modelData)
                anchors{
                    right: parent.right
                    top: parent.top
                    margins: _aliases.spc
                }
                font{
                    pointSize: _aliases.fontSize2
                    bold: true
                }
            }
            Row{
                anchors{
                    bottom: parent.bottom
                    bottomMargin: _aliases.spc
                    horizontalCenter: parent.horizontalCenter
                }
                spacing: _aliases.spc/2
                Button{
                    id:_reduce
                    text:"-"
                    width: height
                    onReleased: {
                        _label.text--
                        _class.setOrderNumber(modelData, -1)
                        if(_label.text != 0)
                        {
                            _price.text = _class.getOrderPrice(modelData)
                        }
                        _controlSum.text = countSum()
                        _orderList.model = _class.getOrderSize()
                    }
                }
                Label{
                    id: _label
                    height: _reduce.height
                    width: 200
                    background: Rectangle{color: "white"}
                    text: _class.getOrderNumber(modelData)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font{
                        pointSize:_aliases.fontSize3
                    }
                }
                Button{
                    id: _increase
                    text:"+"
                    width: height
                    onReleased: {
                        _label.text++
                        _class.setOrderNumber(modelData, 1)
                        _price.text = _class.getOrderPrice(modelData)
                        _controlSum.text = countSum()
                        _orderList.model = _class.getOrderSize()
                    }
                }
            }
        }
    }

    footer:
        Rectangle{
        color: "black"
        width: parent.width
        height: _grid.height
        Grid
        {
            id: _grid
            anchors.centerIn: parent
            leftPadding: 10
            rightPadding: 10
            topPadding: 20
            bottomPadding: 20
            spacing: 10
            columns: 2
            horizontalItemAlignment: Grid.AlignRight
            Text {
                id: _text
                text: qsTr("Итого")
                color: "white"
                font{
                    pointSize: _aliases.fontSize3
                    bold: true
                }

            }
            // КОНТРОЛЬНАЯ СУММА
            Text {
                id:_controlSum
                text: countSum()
                color: "white"
                font{
                    pointSize: _aliases.fontSize3
                    bold: true
                }

            }

            Button{
                id: _delButton
                height: 50
                width: 50
                contentItem: Image{
                    source: "qrc:/Images/delete.png"
                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: "white"
                    }

                }
                background: Rectangle{
                    color: "red"
                    radius: 5
                }
                onReleased: {
                    _class.clearBucket()
                    _orderList.model = _class.getOrderSize()
                    _controlSum.text = countSum()
                }
            }
            // КНОПКА ОПЛАТИТЫ
            Button{
                id:_payButton
                enabled: _orderList.model !== 0
                width: _page.width * 2/3
                height: _delButton.height
                contentItem: Text {
                    text: qsTr("Оплатить")
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font{
                        pointSize: _aliases.fontSize3
                        bold: true
                    }
                }
                background: Rectangle{
                    color: "green"
                    radius: 5
                }
                onReleased: {
                    _class.endOrder()
                    _calendar.refreshPackages()
                    _stack.push(_calendar)
                    _orderList.model = _class.getOrderSize()
                    _controlSum.text = countSum()
                }
            }
        }
    }
}



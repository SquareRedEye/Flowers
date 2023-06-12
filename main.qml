import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "qrc:/mainpage"
import "qrc:/Calendar"
import Flowers 1.0
Window {
    visible: true
    width: Screen.desktopAvailableWidth-16
    height: Screen.desktopAvailableHeight-38
    title: qsTr("Hello World")
    Flowers{
        id:_class
    }

    StackView{
        id: _stack
        initialItem: _mainpage
        anchors.fill: parent
    }

    Page{
        id: _mainpage
        visible: false
        Row{
            anchors.fill: parent
            Galery {

            }
            Bucket {
                id:_bucket
            }
        }
    }
    Calendar {
        id: _calendar
        visible: false
    }
    OrderDetail {
        id:_orderDetail
        visible: false
    }


}

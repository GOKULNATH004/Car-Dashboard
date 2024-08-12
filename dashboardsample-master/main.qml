import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: appWindow
    visible: true
    width: 480
    height: 320
    title: qsTr("RPM Console")
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1
        signal indexChanged(int index);
        onCurrentIndexChanged: indexChanged(currentIndex);





        Dashboard {
        }



    }


}

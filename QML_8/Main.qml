import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    minimumWidth: 400
    minimumHeight: 600
    title: "Swipe"


    SwipeView {
        onCurrentIndexChanged: {
            console.log("Текущая страница:", currentIndex + 1)
        }

        id: swipeView
        anchors.fill: parent
        currentIndex: 0

        Rectangle {
            color: "red"
        }

        Rectangle {
            color: "yellow"
        }

        Rectangle {
            color: "green"
        }
    }

    PageIndicator {
        id: indicator
        count: swipeView.count
        currentIndex: swipeView.currentIndex

        anchors {
            bottom: swipeView.bottom
            horizontalCenter: parent.horizontalCenter
            margins: 20
        }
    }
}

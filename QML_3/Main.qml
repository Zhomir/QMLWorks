import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: "Меню"

    property string currentHeader: "Header"
    property string currentContent: "Content"
    property int activeButton: -1
    property var imageSources: ["images/image1.png", "images/image2.png", "images/image3.png"]

    Rectangle {
        id: header
        width: parent.width
        height: 60
        color: "#f0f0f0"
        border { width: 1; color: "black" }

        Text {
            text: currentHeader
            anchors.centerIn: parent
            font { pixelSize: 24; bold: true }
        }
    }

    Rectangle {
        id: content
        anchors {
            top: header.bottom
            bottom: footer.top
            left: parent.left
            right: parent.right
            margins: 20
        }
        border { width: 2; color: "black" }

        Column {
            anchors.centerIn: parent
            spacing: 15

            Text {
                text: currentContent
                font.pixelSize: 18
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: contentImage
                source: imageSources[activeButton] || ""
                width: 200
                height: 150
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Rectangle {
        id: footer
        width: parent.width
        height: 80
        anchors.bottom: parent.bottom
        color: "#e0e0e0"

        Row {
            anchors.centerIn: parent
            spacing: 30

            Repeater {
                model: 3
                Rectangle {
                    width: 80
                    height: 50
                    radius: 5
                    color: "#4CAF50"
                    opacity: activeButton === index ? 1.0 : 0.5

                    Text {
                        text: index + 1
                        anchors.centerIn: parent
                        color: "white"
                        font { pixelSize: 18; bold: true }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            activeButton = index
                            currentHeader = "Header " + (index + 1)
                            currentContent = "Content " + (index + 1)
                        }
                    }
                }
            }
        }
    }
}

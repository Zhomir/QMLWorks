import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Window {
    width: 360
    height: 640
    visible: true
    title: qsTr("Светофор")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: logoPage // Начальная страница с логотипом
    }

    Component {
        id: logoPage
        Page {
            background: Rectangle { color: "white" }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Label {
                    text: "🚦 Светофор"
                    font.pixelSize: 24
                }

                Button {
                    text: "Начать"
                    onClicked: stackView.push(redPage)
                }
            }
        }
    }

    Component {
        id: redPage
        ColorPage {
            title: "Красный"
            bgColor: "red"
            buttons: [
                {text: "Зеленый", target: greenPage},
                {text: "Желтый", target: yellowPage}
            ]
        }
    }

    Component {
        id: greenPage
        ColorPage {
            title: "Зеленый"
            bgColor: "green"
            buttons: [
                {text: "Красный", target: redPage},
                {text: "Желтый", target: yellowPage}
            ]
        }
    }

    Component {
        id: yellowPage
        ColorPage {
            title: "Желтый"
            bgColor: "yellow"
            buttons: [
                {text: "Красный", target: redPage},
                {text: "Зеленый", target: greenPage}
            ]
        }
    }

    ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 10

            ToolButton {
                visible: stackView.depth > 1
                text: "Назад"
                onClicked: stackView.pop()
            }

            Label {
                text: stackView.currentItem.title || "Светофор"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}

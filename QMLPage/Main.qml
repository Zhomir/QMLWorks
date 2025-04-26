import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 360
    height: 640
    visible: true
    title: "Мессенджер"

    ListModel {
        id: chatModel
        ListElement {messageText: "Тестовое сообщение"; messageTime: "10:00"}
        ListElement {messageText: "Проверка вторая";messageTime: "11:00"}
        ListElement {messageText: "Бог любит троицу";messageTime: "12:00"}
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: chatModel
            spacing: 10
            clip: true

            delegate: Rectangle {
                width: ListView.view.width
                height: messageColumn.height + 25
                radius: 15
                color: "#e3f2fd"


                ColumnLayout {
                    id: messageColumn
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: 10
                        verticalCenter: parent.verticalCenter
                    }

                    Text {
                        text: model.messageText
                        wrapMode: Text.Wrap
                        Layout.fillWidth: true
                    }

                    Text {
                        text: model.messageTime
                        font.pixelSize: 10
                        color: "gray"
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {}
        }

        Rectangle {
            Layout.fillWidth: true
            height: 80
            color: "#f0f0f0"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8

                TextField {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: "Напишите сообщение"
                }

                Button {
                    text: "Отправить"
                    onClicked: {
                        if (messageField.text.trim() !== "") {
                            chatModel.append({
                                messageText: messageField.text,
                                messageTime: Qt.formatTime(new Date(), "hh:mm")
                            })
                            messageField.clear()
                            listView.positionViewAtEnd()
                        }
                    }
                }
            }
        }
    }
}


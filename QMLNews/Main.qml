import QtQuick
import QtQuick.Controls
import QtQml.XmlListModel
import QtQuick.Layouts

Window {
    id: window
    width: 800
    height: 480
    visible: true
    title: "RSS Reader"

    XmlListModel {
        id: feedModel
        source: "https://www.vedomosti.ru/rss/news.xml"
        query: "/rss/channel/item"

        XmlListModelRole { name: "title"; elementName: "title" }
        XmlListModelRole { name: "description"; elementName: "description" }
        XmlListModelRole { name: "pubDate"; elementName: "pubDate" }
        XmlListModelRole { name: "link"; elementName: "link" }
        XmlListModelRole {
            name: "imageUrl"
            elementName: "enclosure"
            attributeName: "url"
        }
    }

    ListView {
        anchors.fill: parent
        model: feedModel
        spacing: 10
        clip: true

        delegate: Item {
            width: ListView.view.width
            height: Math.max(120, col.implicitHeight + 20)

            Rectangle {
                anchors.fill: parent
                anchors.margins: 5
                color: "#f0f0f0"
                radius: 5

                RowLayout {
                    id: row
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    Item {
                        visible: imageUrl !== ""
                        Layout.preferredWidth: visible ? 100 : 0
                        Layout.preferredHeight: 100

                        Image {
                            id: newsImage
                            anchors.fill: parent
                            source: imageUrl
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                        }
                    }

                    ColumnLayout {
                        id: col
                        spacing: 5
                        Layout.fillWidth: true

                        Text {
                            width: parent.width
                            text: title
                            font.bold: true
                            font.pixelSize: 16
                            wrapMode: Text.Wrap
                            color: "black"
                        }

                        Text {
                            width: parent.width
                            text: pubDate
                            font.pixelSize: 12
                            color: "grey"
                        }

                        Text {
                            width: parent.width
                            text: description
                            font.pixelSize: 14
                            wrapMode: Text.Wrap
                            maximumLineCount: 3
                            elide: Text.ElideRight
                            color: "black"
                        }

                        Button {
                            text: "Читать полностью"
                            onClicked: Qt.openUrlExternally(link)
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: feedModel.status === XmlListModel.Loading
    }

    Text {
        anchors.centerIn: parent
        text: "Ошибка загрузки RSS"
        visible: feedModel.status === XmlListModel.Error
        color: "red"
    }
}

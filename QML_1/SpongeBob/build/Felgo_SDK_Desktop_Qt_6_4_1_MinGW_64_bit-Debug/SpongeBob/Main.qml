import QtQuick
import QtQuick.Window

Window {
    width: 800
    height: 600
    visible: true
    title: "Губка Боб"
    color: "lightblue"

    // Компонент глаза
    Component {
        id: eyeComponent

        Item {
            id: eye
            width: 100; height: 100

            property alias corneaColor: cornea.color
            property alias irisColor: iris.color
            property alias pupilColor: pupil.color

            // Белая роговица (внешняя часть)
            Rectangle {
                id: cornea
                anchors.fill: parent
                radius: width/2
                color: "white"
                border.color: "gray"
                border.width: 2

                // Синяя радужка
                Rectangle {
                    id: iris
                    width: 60; height: 60
                    radius: width/2
                    color: "#00BFFF"
                    anchors.centerIn: parent

                    // Черный зрачок
                    Rectangle {
                        id: pupil
                        width: 25; height: 25
                        radius: width/2
                        color: "black"
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

    // Компонент ноги (переработанный)
    Component {
        id: legComponent

        Column {
            id: leg
            spacing: -5

            property alias legColor: legRect.color
            property alias shoeColor: shoe.color

            // Основная часть ноги
            Rectangle {
                id: legRect
                width: 50; height: 80
                color: "#FFEE5A"
                border { color: "#CC9900"; width: 2 }
            }

            // Ботинок
            Rectangle {
                width: 70; height: 30
                color: "white"
                border { color: "black"; width: 2 }

                Rectangle {
                    id: shoe
                    width: 80; height: 30
                    color: "black"
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                    }

                    Rectangle {
                        width: parent.width; height: 5
                        color: "#333333"
                        anchors.bottom: parent.bottom
                    }
                }
            }
        }
    }

    // Основное тело
    Rectangle {
        id: body
        width: 300; height: 400
        color: "#FFEE5A"
        border { color: "#CC9900"; width: 4 }
        radius: 20
        anchors.centerIn: parent

        // Глаза
        Row {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 40
            spacing: 60

            Repeater {
                model: 2
                Loader {
                    sourceComponent: eyeComponent
                    onLoaded: {
                        item.corneaColor = "white"
                        item.irisColor = "#00BFFF"
                        item.pupilColor = "black"
                    }
                }
            }
        }

        // Нос
        Loader {
            sourceComponent: noseComponent
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 130
            }
            onLoaded: {
                item.color = body.color
                item.borderColor = body.border.color
            }
        }

        // Одежда
        Loader {
            sourceComponent: clothesComponent
            anchors.bottom: parent.bottom
            onLoaded: {
                item.shirtColor = "white"
                item.pantsColor = "#663300"
            }
        }

        // Ноги (исправленные привязки)
        Row {
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: -103 // Частично перекрываем тело
            }
            spacing: 40

            Repeater {
                model: 2
                Loader {
                    sourceComponent: legComponent
                    onLoaded: {
                        item.legColor = body.color
                        item.shoeColor = "black"
                    }
                }
            }
        }
    }

    // Компонент носа (остается без изменений)
    Component {
        id: noseComponent

        Rectangle {
            id: nose
            width: 30; height: 75
            radius: 15
            border.width: 2

            property alias color: nose.color
            property alias borderColor: nose.border.color
        }
    }

    // Компонент одежды (остается без изменений)
    Component {
        id: clothesComponent

        Column {
            id: clothes
            spacing: 0

            property alias shirtColor: shirt.color
            property alias pantsColor: pants.color

            Rectangle {
                id: shirt
                width: 300; height: 100
                border { color: "black"; width: 3 }

                Rectangle {
                    width: 40; height: 85
                    color: "#FF0000"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle {
                id: pants
                width: 300; height: 70
                border { color: "black"; width: 2 }

                Row {
                    anchors.centerIn: parent
                    spacing: 100
                    Repeater {
                        model: 2
                        Rectangle {
                            width: 40; height: 30
                            color: "#996633"
                            radius: 5
                        }
                    }
                }
            }
        }
    }
}

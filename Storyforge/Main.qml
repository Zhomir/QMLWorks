import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15


ApplicationWindow {
    id: mainWindow
    visible: true
    minimumWidth: 1200
    minimumHeight: 800
    title: "StoryForge Prototype"

    property bool hasProjects: false
    property string currentStage: "Проекты"
    property string selectedProjectId: ""
    property var savedComponents: ({})
    property color backgroundColor: "#282c34"
    property color textColor: "#ffffff"
    property color buttonColor: "#3e4451"
    property color buttonTextColor: "#ffffff"
    property color leftPanelColor: "#1e2228"
    property color sectionColor: "#3a4049"
    property string projectsFilePath: "projects.json"

    ListModel {
        id: projectModel

    }


    function generateProjectId() {
        return Date.now().toString()
    }

    function removeProject(projectId) {
        for (var i = 0; i < projectModel.count; i++) {
            if (projectModel.get(i).id === projectId) {
                projectModel.remove(i)
                if (selectedProjectId === projectId) selectedProjectId = ""
                break
            }
        }
    }

    function getProjectName(projectId) {
        for (var i = 0; i < projectModel.count; i++) {
            if (projectModel.get(i).id === projectId) return projectModel.get(i).name
        }
        return ""
    }

    function getProjectData(projectId) {
        for (var i = 0; i < projectModel.count; i++) {
            if (projectModel.get(i).id === projectId) {
                return projectModel.get(i)
            }
        }
        return null;
    }

    function saveProjects() {
        var json = JSON.stringify(projectModel.data)
        var file = new File(projectsFilePath)
        if (file.open(File.WriteOnly)) {
            file.write(json)
            file.close()
        } else {
            console.error("Failed to save projects to file.")
        }
    }

    function loadProjects() {
        var file = new File(projectsFilePath)
        if (file.exists && file.open(File.ReadOnly)) {
            var json = file.readAll()
            file.close()
            var data = JSON.parse(json)
            if (data) {
                projectModel.clear()
                for (var i = 0; i < data.length; i++) {
                    projectModel.append(data[i])
                }
            }
        } else {
            console.log("No projects file found, starting fresh.")
        }
    }

    header: Rectangle {
        width: parent.width
        height: 60
        color: backgroundColor

        Row {
            anchors.fill: parent
            spacing: 10
            leftPadding: 10

            ToolButton {
                id: menuButton
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                onClicked: navDrawer.open()

                background: Rectangle {
                    color: "transparent"
                }
            }

            Item {
                width: 2700
                height: 1
            }

            ToolButton {
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    screenLoader.sourceComponent = projectListScreen
                    navDrawer.close()
                }

                contentItem: Image {
                    source: "data:image/svg+xml,%3Csvg width='243' height='48' viewBox='0 0 243 48' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M66.9453 32.7344C66.5312 32.3594 66.4219 32.0312 66.6172 31.75L67.2266 30.8711C67.4375 30.5664 67.7773 30.5898 68.2461 30.9414C68.8633 31.4023 69.5039 31.7812 70.168 32.0781C70.8398 32.375 71.6523 32.5234 72.6055 32.5234C73.3086 32.5234 73.9023 32.418 74.3867 32.207C74.8711 31.9961 75.2578 31.6953 75.5469 31.3047C75.8438 30.9062 75.9922 30.4258 75.9922 29.8633C75.9922 29.457 75.9297 29.082 75.8047 28.7383C75.6875 28.3867 75.4961 28.0938 75.2305 27.8594C74.9648 27.625 74.6875 27.4414 74.3984 27.3086C73.9219 27.0898 73.207 26.8359 72.2539 26.5469C71.3086 26.2578 70.4805 25.9453 69.7695 25.6094C69.0664 25.2734 68.5039 24.8672 68.082 24.3906C67.668 23.9141 67.3906 23.4258 67.25 22.9258C67.1172 22.418 67.0508 21.8398 67.0508 21.1914C67.0508 20.1992 67.3398 19.3438 67.918 18.625C68.4961 17.9062 69.2031 17.4297 70.0391 17.1953C70.8828 16.9609 71.7383 16.8438 72.6055 16.8438C73.5977 16.8438 74.4609 16.9727 75.1953 17.2305C75.9297 17.4883 76.5859 17.8242 77.1641 18.2383C77.5703 18.5273 77.6641 18.832 77.4453 19.1523L76.8477 20.0078C76.668 20.2656 76.3164 20.2109 75.793 19.8438C75.3945 19.5625 74.9062 19.3008 74.3281 19.0586C73.7578 18.8086 73.1914 18.6836 72.6289 18.6836C71.9102 18.6836 71.3125 18.7695 70.8359 18.9414C70.3594 19.1055 69.9844 19.3867 69.7109 19.7852C69.4375 20.1836 69.3008 20.6445 69.3008 21.168C69.3008 21.4961 69.332 21.8008 69.3945 22.082C69.457 22.3555 69.6172 22.6367 69.875 22.9258C70.1328 23.2148 70.4453 23.4375 70.8125 23.5938C71.3047 23.8047 72.0664 24.0547 73.0977 24.3438C74.1367 24.625 75.043 24.9727 75.8164 25.3867C76.5352 25.7695 77.0508 26.1719 77.3633 26.5938C77.6836 27.0078 77.9297 27.4609 78.1016 27.9531C78.2812 28.4375 78.3711 28.9844 78.3711 29.5938C78.3711 30.7031 78.0859 31.6289 77.5156 32.3711C76.9453 33.1133 76.2695 33.6289 75.4883 33.918C74.707 34.207 73.7266 34.3516 72.5469 34.3516C71.1328 34.3516 69.9609 34.1875 69.0312 33.8594C68.1016 33.5312 67.4062 33.1562 66.9453 32.7344ZM80.4102 19.2109C79.9805 19.2109 79.7656 19.0352 79.7656 18.6836V17.7227C79.7656 17.3711 79.9805 17.1953 80.4102 17.1953H92.8086C93.2383 17.1953 93.4531 17.3711 93.4531 17.7227V18.6836C93.4531 19.0352 93.2383 19.2109 92.8086 19.2109H87.7344V33.3555C87.7344 33.7852 87.5391 34 87.1484 34H86.0703C85.6797 34 85.4844 33.7852 85.4844 33.3555V19.2109H80.4102ZM94.9531 25.5977C94.9531 22.8633 95.625 20.7227 96.9688 19.1758C98.3203 17.6211 100.266 16.8438 102.805 16.8438C105.344 16.8438 107.285 17.6211 108.629 19.1758C109.98 20.7227 110.656 22.8633 110.656 25.5977C110.656 28.332 109.98 30.4766 108.629 32.0312C107.285 33.5781 105.344 34.3516 102.805 34.3516C100.266 34.3516 98.3203 33.5781 96.9688 32.0312C95.625 30.4766 94.9531 28.332 94.9531 25.5977ZM97.3555 25.5977C97.3555 27.7852 97.8047 29.4883 98.7031 30.707C99.6016 31.918 100.969 32.5234 102.805 32.5234C104.641 32.5234 106.008 31.918 106.906 30.707C107.805 29.4883 108.254 27.7852 108.254 25.5977C108.254 23.4102 107.805 21.7109 106.906 20.5C106.008 19.2812 104.641 18.6719 102.805 18.6719C100.969 18.6719 99.6016 19.2812 98.7031 20.5C97.8047 21.7109 97.3555 23.4102 97.3555 25.5977ZM114.312 34C113.922 34 113.727 33.7852 113.727 33.3555V17.8398C113.727 17.4102 113.922 17.1953 114.312 17.1953H119.973C122.23 17.1953 123.863 17.6172 124.871 18.4609C125.887 19.3047 126.395 20.418 126.395 21.8008C126.395 23.0195 125.984 24.043 125.164 24.8711C124.352 25.6992 123.191 26.1758 121.684 26.3008V26.3242C122.48 26.918 123.008 27.3711 123.266 27.6836C123.523 27.9883 123.812 28.4023 124.133 28.9258L126.781 33.2266C127.102 33.7422 127.031 34 126.57 34H125.234C124.867 34 124.594 33.8477 124.414 33.543L121.977 29.3594C121.625 28.7578 121.121 28.168 120.465 27.5898C119.809 27.0117 118.992 26.7227 118.016 26.7227H115.977V33.3555C115.977 33.7852 115.781 34 115.391 34H114.312ZM115.977 24.8008H119.363C120.887 24.8008 122.059 24.6016 122.879 24.2031C123.699 23.7969 124.109 22.9492 124.109 21.6602C124.109 20.6758 123.734 20.0078 122.984 19.6562C122.234 19.2969 121.215 19.1172 119.926 19.1172H115.977V24.8008ZM129.207 17.9688C128.871 17.4531 128.977 17.1953 129.523 17.1953H130.836C131.18 17.1953 131.461 17.3867 131.68 17.7695L134.656 22.8906C134.984 23.4531 135.266 23.9453 135.5 24.3672C135.734 24.7812 135.961 25.2227 136.18 25.6914H136.227C136.445 25.2227 136.672 24.7812 136.906 24.3672C137.141 23.9453 137.422 23.4531 137.75 22.8906L140.727 17.7695C140.945 17.3867 141.227 17.1953 141.57 17.1953H142.883C143.43 17.1953 143.535 17.4531 143.199 17.9688L137.328 27.0859V33.3555C137.328 33.7852 137.133 34 136.742 34H135.664C135.273 34 135.078 33.7852 135.078 33.3555V27.0859L129.207 17.9688ZM145.906 34C145.516 34 145.32 33.7852 145.32 33.3555V17.8398C145.32 17.4102 145.516 17.1953 145.906 17.1953H155.457C155.887 17.1953 156.102 17.3711 156.102 17.7227V18.5898C156.102 18.9414 155.887 19.1172 155.457 19.1172H147.57V24.6719H154.449C154.879 24.6719 155.094 24.8477 155.094 25.1992V26.0664C155.094 26.418 154.879 26.5938 154.449 26.5938H147.57V33.3555C147.57 33.7852 147.375 34 146.984 34H145.906ZM158.07 25.5977C158.07 22.8633 158.742 20.7227 160.086 19.1758C161.438 17.6211 163.383 16.8438 165.922 16.8438C168.461 16.8438 170.402 17.6211 171.746 19.1758C173.098 20.7227 173.773 22.8633 173.773 25.5977C173.773 28.332 173.098 30.4766 171.746 32.0312C170.402 33.5781 168.461 34.3516 165.922 34.3516C163.383 34.3516 161.438 33.5781 160.086 32.0312C158.742 30.4766 158.07 28.332 158.07 25.5977ZM160.473 25.5977C160.473 27.7852 160.922 29.4883 161.82 30.707C162.719 31.918 164.086 32.5234 165.922 32.5234C167.758 32.5234 169.125 31.918 170.023 30.707C170.922 29.4883 171.371 27.7852 171.371 25.5977C171.371 23.4102 170.922 21.7109 170.023 20.5C169.125 19.2812 167.758 18.6719 165.922 18.6719C164.086 18.6719 162.719 19.2812 161.82 20.5C160.922 21.7109 160.473 23.4102 160.473 25.5977ZM177.43 34C177.039 34 176.844 33.7852 176.844 33.3555V17.8398C176.844 17.4102 177.039 17.1953 177.43 17.1953H183.09C185.348 17.1953 186.98 17.6172 187.988 18.4609C189.004 19.3047 189.512 20.418 189.512 21.8008C189.512 23.0195 189.102 24.043 188.281 24.8711C187.469 25.6992 186.309 26.1758 184.801 26.3008V26.3242C185.598 26.918 186.125 27.3711 186.383 27.6836C186.641 27.9883 186.93 28.4023 187.25 28.9258L189.898 33.2266C190.219 33.7422 190.148 34 189.688 34H188.352C187.984 34 187.711 33.8477 187.531 33.543L185.094 29.3594C184.742 28.7578 184.238 28.168 183.582 27.5898C182.926 27.0117 182.109 26.7227 181.133 26.7227H179.094V33.3555C179.094 33.7852 178.898 34 178.508 34H177.43ZM179.094 24.8008H182.48C184.004 24.8008 185.176 24.6016 185.996 24.2031C186.816 23.7969 187.227 22.9492 187.227 21.6602C187.227 20.6758 186.852 20.0078 186.102 19.6562C185.352 19.2969 184.332 19.1172 183.043 19.1172H179.094V24.8008ZM192.266 25.5977C192.266 22.8633 192.973 20.7227 194.387 19.1758C195.801 17.6211 197.766 16.8438 200.281 16.8438C201.789 16.8438 203.02 17.1055 203.973 17.6289C204.926 18.1445 205.625 18.7539 206.07 19.457C206.344 19.8945 206.34 20.2109 206.059 20.4062L205.18 21.0156C204.891 21.2188 204.602 21.0977 204.312 20.6523C204.078 20.3008 203.637 19.8828 202.988 19.3984C202.34 18.9141 201.477 18.6719 200.398 18.6719C198.484 18.6719 197.051 19.2812 196.098 20.5C195.145 21.7109 194.668 23.4102 194.668 25.5977C194.668 27.7852 195.133 29.4883 196.062 30.707C196.992 31.918 198.477 32.5234 200.516 32.5234C201.531 32.5234 202.414 32.4023 203.164 32.1602C203.922 31.9102 204.453 31.5664 204.758 31.1289V28.0234H201.277C200.848 28.0234 200.633 27.8477 200.633 27.4961V26.6289C200.633 26.2773 200.848 26.1016 201.277 26.1016H206.363C206.793 26.1016 207.008 26.2773 207.008 26.6289V32.1602C206.055 32.8555 205.102 33.3945 204.148 33.7773C203.195 34.1602 201.945 34.3516 200.398 34.3516C197.82 34.3516 195.82 33.5781 194.398 32.0312C192.977 30.4766 192.266 28.332 192.266 25.5977ZM210.992 34C210.602 34 210.406 33.7852 210.406 33.3555V17.8398C210.406 17.4102 210.602 17.1953 210.992 17.1953H221.246C221.676 17.1953 221.891 17.3711 221.891 17.7227V18.5898C221.891 18.9414 221.676 19.1172 221.246 19.1172H212.656V24.3203H220.543C220.973 24.3203 221.188 24.4961 221.188 24.8477V25.7148C221.188 26.0664 220.973 26.2422 220.543 26.2422H212.656V32.0781H221.598C222.027 32.0781 222.242 32.2539 222.242 32.6055V33.4727C222.242 33.8242 222.027 34 221.598 34H210.992Z' fill='white'/%3E%3Cpath d='M14.0156 14L14.6406 16H0V17C0 21.598 7.96848 25.3725 18.2715 25.7285L20.2695 32H21.9648L19.8926 39.6191H37.5391L36.0195 32H37.7285L37.9512 31.3066C39.7272 25.7866 44.3665 21.1276 49.2305 19.9746L50 19.791V14H14.0156ZM16.7344 16H48V18.2344C42.985 19.7574 38.3192 24.437 36.2852 30H34.3828L32.8828 33H34.1797L35.1016 37.6191H22.5098L23.7637 33H24.8184L23.6934 30H21.7305L19.7422 23.7617L19.0254 23.748C10.0794 23.579 3.55023 20.763 2.24023 18H17.3594L16.7344 16ZM30.6562 17.5C30.6562 17.5 28.6739 18.3396 28.2109 19.2656C27.6679 20.3526 28.3464 21.3037 28.4824 21.8477C28.6184 22.3917 27.5318 22.1197 27.2598 21.3047C26.9888 22.3917 27.125 22.5288 27.668 23.3438C28.242 24.2048 28.3978 26.0605 26.7168 26.0605C24.9508 26.0605 25.6309 23.75 25.6309 23.75C25.6309 23.75 24 24.5648 24 25.9238C24 28.3698 26.1747 28.9133 27.2617 28.7773C28.3487 28.6413 29.1621 30 29.1621 30C29.2981 29.321 29.5703 29.1846 30.1133 29.1836C30.7213 29.1836 31.6081 28.9127 32.2871 28.0977C33.5801 26.5457 33.2383 25.3795 32.6953 24.5645C32.9673 26.8745 31.4727 27.0098 30.9297 27.0098C30.1977 27.0098 29.4352 25.6521 30.6582 25.2441C31.8802 24.8361 31.3379 23.8848 31.3379 23.8848C31.3379 23.8848 30.9283 24.6993 30.1133 24.1562C29.3133 23.6243 30.793 22.5273 30.793 22.5273C30.793 22.5273 29.4348 21.3055 29.2988 19.8105C29.1628 18.3155 30.6562 17.5 30.6562 17.5Z' fill='white'/%3E%3C/svg%3E"
                    width: 121.5  
                    height: 24   
                }
            }

            Item {
                width: parent.width - menuButton.width - newProjectButton.width - openProjectButton.width - 50 - 27
            }

            Row {
                spacing: 5
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                ToolButton {
                    id: newProjectButton
                    width: 40
                    height: 40
                    onClicked: {
                        screenLoader.sourceComponent = createProjectScreen
                        navDrawer.close()
                    }
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Image {
                        source: "data:image/svg+xml,%3Csvg width='70' height='72' viewBox='0 0 70 72' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg clip-path='url(%23clip0_1_38)'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M48.125 38.25H37.1875V49.5C37.1875 50.7375 36.2075 51.75 35 51.75C33.7925 51.75 32.8125 50.7375 32.8125 49.5V38.25H21.875C20.6675 38.25 19.6875 37.2375 19.6875 36C19.6875 34.7625 20.6675 33.75 21.875 33.75H32.8125V22.5C32.8125 21.2625 33.7925 20.25 35 20.25C36.2075 20.25 37.1875 21.2625 37.1875 22.5V33.75H48.125C49.3325 33.75 50.3125 34.7625 50.3125 36C50.3125 37.2375 49.3325 38.25 48.125 38.25ZM61.25 0H8.75C3.91781 0 0 4.0275 0 9V63C0 67.9725 3.91781 72 8.75 72H61.25C66.0822 72 70 67.9725 70 63V9C70 4.0275 66.0822 0 61.25 0Z' fill='white'/%3E%3C/g%3E%3Cdefs%3E%3CclipPath id='clip0_1_38'%3E%3Crect width='70' height='72' fill='white'/%3E%3C/clipPath%3E%3C/defs%3E%3C/svg%3E"
                        width: 24
                        height: 24
                        anchors.centerIn: parent
                    }
                }

                ToolButton {
                    id: openProjectButton
                    width: 40
                    height: 40
                    onClicked: {
                        navDrawer.open()
                    }
                    background: Rectangle {
                        color: "transparent"
                    }
                    contentItem: Image {
                        source: "data:image/svg+xml,%3Csvg width='79' height='72' viewBox='0 0 79 72' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg clip-path='url(%23clip0_1_42)'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M19.75 42.0016H13.1667V54.0016H0.0954583L0 60.0016H13.1667V72.0016H19.75V60.0016H33.1504L33.2491 54.0016H19.75V42.0016ZM79 12.0016V60.0016H39.5V54.0016H72.4167V18.0016H44.0228L37.5777 6.00165H19.75V36.0016H13.1667V0.00164795H40.9385L47.5218 12.0016H79Z' fill='white'/%3E%3C/g%3E%3Cdefs%3E%3CclipPath id='clip0_1_42'%3E%3Crect width='79' height='72' fill='white'/%3E%3C/clipPath%3E%3C/defs%3E%3C/svg%3E"
                        width: 24
                        height: 24
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

    Drawer {
        id: navDrawer
        width: 250
        height: parent.height
        edge: Qt.LeftEdge
        background: Rectangle {
            color: leftPanelColor
            border.color: Qt.darker(leftPanelColor, 1.2)
            border.width: 1
        }

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: "transparent"

                Text {
                    text: "Проект"
                    color: textColor
                    font.pixelSize: 18
                    font.bold: true
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            ListView {
                id: navList
                currentIndex: -1
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: ListModel {
                    ListElement {
                        title: "Синопсис"
                        icon: "data:image/svg+xml,%3Csvg width='56' height='64' viewBox='0 0 56 64' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M33.25 11.9454V20.0991C33.2495 20.3957 33.2491 20.8186 33.2988 21.1815C33.3594 21.6253 33.5589 22.482 34.3352 23.0029C35.0828 23.5045 35.8139 23.3182 36.1615 23.1947C36.4644 23.0871 36.7967 22.9063 37.0445 22.7714L39.6667 21.3478L42.2889 22.7714C42.5367 22.9062 42.8689 23.0871 43.1718 23.1947C43.5195 23.3182 44.2505 23.5045 44.9981 23.0029C45.7744 22.482 45.9739 21.6253 46.0346 21.1815C46.0843 20.8186 46.0838 20.3958 46.0833 20.0992V8.08338C46.3465 8.06924 46.6051 8.0573 46.8575 8.04724C49.3584 7.94767 51.3329 10.2952 51.3329 13.1551V43.0495C51.3329 46.0122 49.2189 48.4092 46.6317 48.594C44.3695 48.7559 41.7118 49.0719 39.6662 49.689C37.1429 50.4498 35.0247 52.5354 31.7973 53.5178C30.3364 53.9626 28.7068 54.2018 28 54.3799V13.7969C28.7485 13.5874 31.2251 13.257 31.9053 12.8072C32.3351 12.5228 32.7861 12.2328 33.25 11.9454ZM46.0311 34.1815C46.2656 35.253 45.6953 36.3388 44.7578 36.6068L35.4244 39.2735C34.4869 39.5415 33.5368 38.8898 33.3023 37.8183C33.0678 36.7468 33.638 35.661 34.5756 35.393L43.9089 32.7263C44.8464 32.4583 45.7966 33.11 46.0311 34.1815Z' fill='white'/%3E%3Cpath d='M42.5833 8.40259C41.1367 8.59805 39.7143 8.88413 38.4995 9.29973C37.936 9.49256 37.3478 9.73699 36.75 10.017V10.5333V18.5028L38.4984 17.5537L38.5189 17.5418C38.6332 17.475 39.1151 17.1934 39.6667 17.1934C39.7775 17.1934 39.8858 17.2048 39.9887 17.2235C40.3972 17.298 40.723 17.4884 40.8144 17.5418L40.835 17.5536L42.5833 18.5028V9.72429V8.40259Z' fill='white'/%3E%3Cpath opacity='0.5' d='M27.9998 13.9039C27.22 13.7347 25.5326 13.4738 23.9919 13.0013C20.8554 12.0394 18.7813 10.0382 16.3332 9.29987C14.2646 8.67605 11.5703 8.35976 9.2921 8.19974C6.73454 8.02008 4.6665 10.399 4.6665 13.3275V43.0497C4.6665 46.0121 6.78062 48.4091 9.36784 48.5942C11.6298 48.7558 14.2875 49.0721 16.3332 49.6889C17.4671 50.031 19.1709 50.8387 20.7034 51.6246C23.0474 52.8267 25.4908 53.7483 27.9998 54.3803V13.9039Z' fill='white'/%3E%3Cpath d='M9.96917 34.1822C10.2036 33.1104 11.1537 32.459 12.0914 32.727L21.4247 35.3936C22.3623 35.6614 22.9324 36.7472 22.698 37.819C22.4636 38.8904 21.5135 39.5419 20.5758 39.2742L11.2425 36.6075C10.3048 36.3395 9.73476 35.2536 9.96917 34.1822Z' fill='white'/%3E%3Cpath d='M12.0914 22.0602C11.1537 21.7923 10.2036 22.4438 9.96917 23.5154C9.73476 24.587 10.3048 25.6729 11.2425 25.9407L20.5758 28.6075C21.5135 28.8752 22.4636 28.2237 22.698 27.1523C22.9324 26.0806 22.3623 24.9947 21.4247 24.7269L12.0914 22.0602Z' fill='white'/%3E%3C/svg%3E"
                    }
                    ListElement {
                        title: "Заметки"
                        icon: "data:image/svg+xml,%3Csvg width='62' height='56' viewBox='0 0 62 56' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M51.1913 4.6667H43.9172V3.5537C43.9172 1.59064 42.1562 0 39.9828 0H22.0183C19.845 0 18.0838 1.59064 18.0838 3.5537V4.6667H10.8087C7.69252 4.6667 5.16675 6.94805 5.16675 9.7627V50.904C5.16675 53.7187 7.69252 56 10.8087 56H51.1915C54.3077 56 56.8335 53.7187 56.8335 50.904V9.7627C56.8333 6.94805 54.3076 4.6667 51.1913 4.6667ZM23.2505 4.6667H38.75V9.33341H23.2505V4.6667ZM51.6667 50.904C51.6667 51.1413 51.4542 51.3333 51.1915 51.3333H10.8087C10.546 51.3333 10.3335 51.1413 10.3335 50.904V9.7627C10.3335 9.52536 10.546 9.33341 10.8087 9.33341H18.0835V10.4464C18.0835 12.4094 19.8445 14.0001 22.0179 14.0001H22.0184H39.9824H39.9829C42.1562 14.0001 43.9174 12.4095 43.9174 10.4464V9.3333H51.1915C51.4542 9.3333 51.6667 9.52525 51.6667 9.76259V50.904Z' fill='white'/%3E%3Cpath d='M25.8333 21H15.5V30.3333H25.8333V21Z' fill='white'/%3E%3Cpath d='M25.8333 37.3333H15.5V46.6665H25.8333V37.3333Z' fill='white'/%3E%3Cpath d='M42.0902 19.3502L36.1669 24.7002L35.4103 24.0169C34.4014 23.1057 32.7657 23.1057 31.7569 24.0169C30.748 24.9281 30.748 26.4055 31.7569 27.3167L34.3402 29.65C35.349 30.5612 36.9847 30.5612 37.9936 29.65L45.7436 22.65C46.7524 21.7388 46.7524 20.2614 45.7436 19.3502C44.7346 18.4389 43.099 18.4389 42.0902 19.3502Z' fill='white'/%3E%3Cpath d='M42.0902 35.6834L36.1669 41.0335L35.4103 40.3501C34.4014 39.4389 32.7657 39.4389 31.7569 40.3501C30.748 41.2613 30.748 42.7387 31.7569 43.65L34.3402 45.9832C35.349 46.8945 36.9847 46.8945 37.9936 45.9832L45.7436 38.9832C46.7524 38.072 46.7524 36.5946 45.7436 35.6834C44.7346 34.7722 43.099 34.7722 42.0902 35.6834Z' fill='white'/%3E%3C/svg%3E"
                    }
                    ListElement {
                        title: "Текст"
                        icon: "data:image/svg+xml,%3Csvg width='65' height='63' viewBox='0 0 65 63' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M46.7188 33.4688H18.2812V37.4062H46.7188V33.4688Z' fill='white'/%3E%3Cpath d='M46.7188 41.3438H18.2812V45.2812H46.7188V41.3438Z' fill='white'/%3E%3Cpath d='M46.7188 25.5938H18.2812V29.5312H46.7188V25.5938Z' fill='white'/%3E%3Cpath d='M46.7188 7.875V3.9375H42.6562V7.875H34.5312V3.9375H30.4688V7.875H22.3438V3.9375H18.2812V7.875H8.125V59.0625H56.875V7.875H46.7188ZM52.8125 55.125H12.1875V11.8125H18.2812V15.75H22.3438V11.8125H30.4688V15.75H34.5312V11.8125H42.6562V15.75H46.7188V11.8125H52.8125V55.125Z' fill='white'/%3E%3C/svg%3E"
                    }
                    ListElement {
                        title: "Раскадровка"
                        icon: "data:image/svg+xml,%3Csvg width='52' height='67' viewBox='0 0 52 67' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M50.375 8.375H1.625C0.65 8.375 0 9.2125 0 10.4688V56.5312C0 57.7875 0.65 58.625 1.625 58.625H50.375C51.35 58.625 52 57.7875 52 56.5312V10.4688C52 9.2125 51.35 8.375 50.375 8.375ZM16.25 48.1562V54.4375H11.375V48.1562H16.25ZM19.5 48.1562H24.375V54.4375H19.5V48.1562ZM27.625 48.1562H32.5V54.4375H27.625V48.1562ZM35.75 48.1562H40.625V54.4375H35.75V48.1562ZM35.75 18.8438V12.5625H40.625V18.8438H35.75ZM32.5 18.8438H27.625V12.5625H32.5V18.8438ZM24.375 18.8438H19.5V12.5625H24.375V18.8438ZM16.25 18.8438H11.375V12.5625H16.25V18.8438ZM48.75 18.8438H43.875V12.5625H48.75V18.8438ZM8.125 12.5625V18.8438H3.25V12.5625H8.125ZM3.25 48.1562H8.125V54.4375H3.25V48.1562ZM43.875 54.4375V48.1562H48.75V54.4375H43.875Z' fill='white'/%3E%3C/svg%3E"
                    }
                    ListElement {
                        title: "Статистика"
                        icon: "data:image/svg+xml,%3Csvg width='57' height='56' viewBox='0 0 57 56' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg clip-path='url(%23clip0_1_439)'%3E%3Cpath d='M25.6501 28L41.3251 52L57.0001 28H25.6501Z' fill='white'/%3E%3Cpath d='M28.5 4V20H44.7857V4H28.5ZM40.7143 16H32.5714V8H40.7143V16Z' fill='white'/%3E%3Cpath d='M4.07153 4V20H20.3572V4H4.07153ZM16.2858 16H8.14296V8H16.2858V16Z' fill='white'/%3E%3Cpath d='M4.07153 28V44H20.3572V28H4.07153ZM16.2858 40H8.14296V32H16.2858V40Z' fill='white'/%3E%3C/g%3E%3Cdefs%3E%3CclipPath id='clip0_1_439'%3E%3Crect width='57' height='56' fill='white'/%3E%3C/clipPath%3E%3C/defs%3E%3C/svg%3E"
                    }
                    ListElement {
                        title: "AI-Ассистент"
                        icon: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'%3E%3Cg fill='none' stroke='%23ffffff' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5'%3E%3Cpath d='M4 16.5a3 3 0 0 0 3 3a2.5 2.5 0 0 0 5 0a2.5 2.5 0 1 0 5 0a3 3 0 0 0 2.567-4.553a3.001 3.001 0 0 0 0-5.893A3 3 0 0 0 17 4.5a2.5 2.5 0 1 0-5 0a2.5 2.5 0 0 0-5 0a3 3 0 0 0-2.567 4.553a3.001 3.001 0 0 0 0 5.893A3 3 0 0 0 4 16.5'/%3E%3Cpath d='m7.5 14.5l1.842-5.526a.694.694 0 0 1 1.316 0L12.5 14.5m3-6v6m-7-2h3'/%3E%3C/g%3E%3C/svg%3E"
                    }
                }

                delegate: ItemDelegate {
                    width: parent.width
                    height: 50
                    text: model.title
                    enabled: selectedProjectId !== ""

                    background: Rectangle {
                        anchors.fill: parent
                        color: "#1e2228"  // Цвет совпадает с leftPanelColor
                    }

                    contentItem: Row {
                        spacing: 15
                        leftPadding: 20

                        Item {
                            width: 24
                            height: 24
                            anchors.verticalCenter: parent.verticalCenter

                            Image {
                                source: model.icon
                                width: 24
                                height: 24
                                anchors.centerIn: parent
                            }
                        }

                        Text {
                            text: model.title
                            font.pixelSize: 16
                            color: enabled ? textColor : Qt.darker(textColor, 1.5)
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    onClicked: {
                        currentStage = model.title
                        screenLoader.sourceComponent = getComponent(model.title)
                        navDrawer.close()
                    }
                }

            }

            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: "transparent"

                Button {
                    text: "Добавить документ"
                    width: parent.width - 40
                    height: 40
                    anchors.centerIn: parent
                    background: Rectangle {
                        color: buttonColor
                        radius: 5
                    }
                    contentItem: Text {
                        text: parent.text
                        color: buttonTextColor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onClicked: {
                    }
                }
            }
        }
    }

    Loader {
        id: screenLoader
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        sourceComponent: getComponent(currentStage)
    }

    Component {
        id: projectListScreen
        Rectangle {
            color: backgroundColor
            anchors.fill: parent

            Row {
                anchors.fill: parent

                // Left Sidebar
                Rectangle {
                    id: sidebar
                    width: parent.width * 0.3
                    height: parent.height
                    color: leftPanelColor
                    anchors.left: parent.left

                    Column {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 20

                        Column {
                            width: parent.width
                            spacing: 5
                            anchors.top: parent.top
                            anchors.topMargin: 20

                            Text {
                                width: parent.width
                                text: "Трагическое подражание или\nвоспроизведение совершается в\nдействии, а не в рассказе."
                                font.pixelSize: 20
                                color: textColor
                                wrapMode: Text.Wrap
                                horizontalAlignment: Text.AlignLeft
                            }

                            Text {
                                text: "Аристотель"
                                font.pixelSize: 14
                                color: textColor
                            }
                        }

                        Column {
                            width: parent.width
                            spacing: 15
                            anchors.top: parent.top
                            anchors.topMargin: 150

                            Button {
                                id: createButton
                                text: "Создать историю"
                                font.pixelSize: 16
                                width: parent.width - 40
                                height: 50
                                anchors.horizontalCenter: parent.horizontalCenter

                                background: Rectangle {
                                    color: buttonColor
                                    radius: 5
                                }

                                contentItem: Row {
                                    spacing: 8
                                    anchors.centerIn: parent

                                    Image {
                                        source: "data:image/svg+xml,%3Csvg width='70' height='72' viewBox='0 0 70 72' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg clip-path='url(%23clip0_1_38)'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M48.125 38.25H37.1875V49.5C37.1875 50.7375 36.2075 51.75 35 51.75C33.7925 51.75 32.8125 50.7375 32.8125 49.5V38.25H21.875C20.6675 38.25 19.6875 37.2375 19.6875 36C19.6875 34.7625 20.6675 33.75 21.875 33.75H32.8125V22.5C32.8125 21.2625 33.7925 20.25 35 20.25C36.2075 20.25 37.1875 21.2625 37.1875 22.5V33.75H48.125C49.3325 33.75 50.3125 34.7625 50.3125 36C50.3125 37.2375 49.3325 38.25 48.125 38.25ZM61.25 0H8.75C3.91781 0 0 4.0275 0 9V63C0 67.9725 3.91781 72 8.75 72H61.25C66.0822 72 70 67.9725 70 63V9C70 4.0275 66.0822 0 61.25 0Z' fill='white'/%3E%3C/g%3E%3Cdefs%3E%3CclipPath id='clip0_1_38'%3E%3Crect width='70' height='72' fill='white'/%3E%3C/clipPath%3E%3C/defs%3E%3C/svg%3E"
                                        width: 24
                                        height: 24

                                    }

                                    Label {
                                        text: "Создать историю"
                                        font.pixelSize: 16
                                        color: buttonTextColor
                                    }
                                }
                                onClicked: {
                                   screenLoader.sourceComponent = createProjectScreen
                                }
                            }


                            Button {
                                id: openButton
                                text: "Открыть историю"
                                font.pixelSize: 16
                                width: parent.width - 40
                                height: 50
                                anchors.horizontalCenter: parent.horizontalCenter

                                background: Rectangle {
                                    color: buttonColor
                                    radius: 5
                                }

                                contentItem: Row {
                                    spacing: 8
                                    anchors.centerIn: parent

                                    Image {
                                        source: "data:image/svg+xml,%3Csvg width='79' height='72' viewBox='0 0 79 72' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cg clip-path='url(%23clip0_1_42)'%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M19.75 42.0016H13.1667V54.0016H0.0954583L0 60.0016H13.1667V72.0016H19.75V60.0016H33.1504L33.2491 54.0016H19.75V42.0016ZM79 12.0016V60.0016H39.5V54.0016H72.4167V18.0016H44.0228L37.5777 6.00165H19.75V36.0016H13.1667V0.00164795H40.9385L47.5218 12.0016H79Z' fill='white'/%3E%3C/g%3E%3Cdefs%3E%3CclipPath id='clip0_1_42'%3E%3Crect width='79' height='72' fill='white'/%3E%3C/clipPath%3E%3C/defs%3E%3C/svg%3E"
                                        width: 24
                                        height: 24

                                    }

                                    Label {
                                        text: "Открыть историю"
                                        font.pixelSize: 16
                                        color: buttonTextColor
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width * 0.7
                    height: parent.height
                    color: backgroundColor
                    anchors.right: parent.right

                    ListView {
                        anchors.fill: parent
                        model: projectModel
                        delegate: ItemDelegate {
                            width: parent.width
                               height: 50

                               contentItem: Text {
                                   text: model.name + " (" + model.genre + ")"
                                   color: selectedProjectId === model.id ? "#000000" : textColor
                                   font.pixelSize: 16
                                   verticalAlignment: Text.AlignVCenter
                                   leftPadding: 10
                               }

                               background: Rectangle {
                                   color: selectedProjectId === model.id ? "white" : "transparent"
                               }

                               onClicked: {
                                   mainWindow.selectedProjectId = model.id;
                                   navDrawer.open();
                                   mainWindow.currentStage = "Синопсис";
                                   mainWindow.screenLoader.sourceComponent = mainWindow.settingsScreen;
                               }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: createProjectScreen
        Rectangle {
            color: backgroundColor
            anchors.fill: parent

            Column {
                anchors.centerIn: parent
                spacing: 15
                width: 400

                Text {
                    text: "Этап 1 - Создание вашего проекта"
                    font.pixelSize: 24
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField {
                    id: projectNameInput
                    placeholderText: "Название проекта"
                    width: 300
                    placeholderTextColor: Qt.lighter(textColor, 1.5) // Цвет плейсхолдера
                }

                Label {
                    id: projectNameError
                    text: ""
                    color: "red"
                    visible: false
                }

                Button {
                    text: "Выбрать обложку"
                    onClicked: console.log("Обложка выбрана")
                }

                ComboBox {
                    id: comboBox
                    width: 300
                    model: ["RPG", "Квест", "Экшен", "Визуальная новелла"]
                    currentIndex: 0
                }

                Button {
                    text: "Создать"
                    onClicked: {
                        if (projectNameInput.text.trim() === "") {
                            projectNameError.text = "Название проекта не может быть пустым."
                            projectNameError.visible = true
                        } else if (projectNameInput.text.length > 50) {
                            projectNameError.text = "Название проекта слишком длинное."
                            projectNameError.visible = true
                        } else {
                            projectNameError.visible = false;
                            projectModel.append({
                                id: generateProjectId(),
                                name: projectNameInput.text,
                                genre: comboBox.currentText,
                                script: "",
                                notes: "",
                                storyboard: "",
                                chatHistory: Qt.createQmlObject('import QtQuick 2.15; ListModel {}', parent)
                            })
                            screenLoader.sourceComponent = projectListScreen
                        }
                    }
                }

                Button {
                    text: "Отмена"
                    onClicked: screenLoader.sourceComponent = projectListScreen
                }
            }
        }
    }

    Component {
        id: settingsScreen
        Rectangle {
            color: backgroundColor
            property var projectData: mainWindow.getProjectData(mainWindow.selectedProjectId)

            Column {
                anchors.fill: parent
                padding: 40
                spacing: 20

                Text {
                    text: "SCRIPT TITLE"
                    font.pixelSize: 24
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Written by"
                    font.pixelSize: 18
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField {
                    id: authorName
                    width: parent.width * 0.6
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Name of first author"
                    text: projectData ? projectData.author : ""
                    onTextChanged: if (projectData) projectData.author = text
                }

                Text {
                    text: "Based on, if any"
                    font.pixelSize: 18
                    color: textColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                TextField {
                    id: basedOn
                    width: parent.width * 0.6
                    color: textColor // Добавлено
                    anchors.horizontalCenter: parent.horizontalCenter
                    placeholderText: "Based on..."
                    text: projectData ? projectData.basedOn : ""
                    onTextChanged: if (projectData) projectData.basedOn = text
                }

                Column {
                    width: parent.width * 0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 15

                    Text {
                        text: "Настройки проекта:"
                        font.pixelSize: 18
                        color: textColor
                    }

                    Button {
                        text: "Сменить обложку"
                        onClicked: console.log("Changing cover image")
                    }

                    ComboBox {
                        id: genreComboBox
                        width: 200
                        model: ["RPG", "Квест", "Экшен", "Визуальная новелла"]
                        currentIndex: model.indexOf(projectData ? projectData.genre : "RPG")
                        onActivated: if (projectData) projectData.genre = currentText
                    }

                    Button {
                        text: "Удалить проект"
                        onClicked: {
                            if (projectData) {
                                removeProject(projectData.id)
                                currentStage = "Проекты"
                                screenLoader.sourceComponent = projectListScreen
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: scriptEditor
        Rectangle {
            color: backgroundColor
            property var projectData: mainWindow.getProjectData(mainWindow.selectedProjectId)

            TextArea {
                anchors.fill: parent
                color: textColor
                text: projectData ? projectData.script : ""
                onTextChanged: if (projectData) projectData.script = text
                placeholderTextColor: textColor
                placeholderText: "Начните писать ваш сценарий..."
                wrapMode: TextArea.Wrap
                background: Rectangle { color: backgroundColor }
            }
        }
    }

    Component {
        id: notesScreen
        Rectangle {
            color: backgroundColor
            property var projectData: mainWindow.getProjectData(mainWindow.selectedProjectId)

            TextArea {
                anchors.fill: parent
                text: projectData ? projectData.notes : ""
                onTextChanged: if (projectData) projectData.notes = text
                placeholderTextColor: textColor
                placeholderText: "Добавьте заметки и идеи..."
                wrapMode: TextArea.Wrap
                color: textColor
                background: Rectangle {
                    color: backgroundColor }
            }
        }
    }

    Component {
        id: storyboardScreen
        Rectangle {
            color: backgroundColor
            property var projectData: mainWindow.getProjectData(mainWindow.selectedProjectId)

            Column {
                anchors.fill: parent
                padding: 20
                spacing: 15

                GridView {
                    width: parent.width
                    height: 420
                    cellWidth: 250
                    cellHeight: 120
                    model: 9

                    delegate: Rectangle {
                        width: 230
                        height: 100
                        color: "#1a1a1a"
                        radius: 6
                        border.color: "#444"

                        Row {
                            anchors.fill: parent
                            spacing: 5

                            Rectangle {
                                width: 10; height: parent.height
                                color: "black"
                                Repeater {
                                    model: 5
                                    Rectangle {
                                        width: 10; height: 6
                                        color: "white"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        y: index * 18
                                    }
                                }
                            }

                            Rectangle {
                                width: 190
                                height: parent.height
                                color: "#2e2e2e"
                                Image {
                                    anchors.centerIn: parent
                                    source: "film_placeholder.png"
                                    width: 160
                                    height: 80
                                    fillMode: Image.PreserveAspectFit
                                }
                            }

                            Rectangle {
                                width: 10; height: parent.height
                                color: "black"
                                Repeater {
                                    model: 5
                                    Rectangle {
                                        width: 10; height: 6
                                        color: "white"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        y: index * 18
                                    }
                                }
                            }
                        }
                    }
                }

                Row {
                    spacing: 15
                    Button {
                        text: "➕ Сгенерировать нейросетью"
                        onClicked: generateWithAI()
                        background: Rectangle {
                            color: buttonColor
                            radius: 5
                        }
                    }

                    Button {
                        text: "📁 Загрузить свою"
                        onClicked: fileDialog.open()
                        background: Rectangle {
                            color: buttonColor
                            radius: 5
                        }
                    }
                }

                GridView {
                    id: grid
                    width: parent.width
                    height: parent.height - 640 // адаптировано под высоту кинокадров и кнопок
                    cellWidth: 250
                    cellHeight: 200
                    model: projectData && projectData.storyboardList ? projectData.storyboardList : null

                    delegate: Rectangle {
                        width: 230
                        height: 180
                        color: sectionColor
                        radius: 8

                        Image {
                            anchors.fill: parent
                            source: model.image || "placeholder.png"
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            anchors.bottom: parent.bottom
                            text: "Кадр #" + (index + 1)
                            color: textColor
                            padding: 8
                        }
                    }
                }

                Text {
                    text: `Кадров: ${grid.count}`
                    color: textColor
                    font.italic: true
                }
            }
        }
    }







    Component {
            id: assistantScreen
            Rectangle {
                color: "#f0faff"

                property var projectData: {
                    for (var i = 0; i < projectModel.count; i++) {
                        if (projectModel.get(i).id === selectedProjectId) {
                            return projectModel.get(i)
                        }
                    }
                    return null
                }

                ListModel {
                    id: localChatModel
                }

                function generateFakeAnswer() {
                    var answers = [
                        "Создаю уникальный диалог для вашей RPG-сцены...",
                        "Разрабатываю сюжетный поворот для квеста...",
                        "Генерирую описание локации в стиле " + (projectData ? projectData.genre : "RPG"),
                        "Предлагаю вариант развития персонажа: ..."
                    ]
                    return answers[Math.floor(Math.random() * answers.length)]
                }

                Timer {
                    id: loadingTimer
                    interval: 2000
                    repeat: false
                    onTriggered: {
                        if (localChatModel.count > 0) {
                            var lastIndex = localChatModel.count - 1
                            localChatModel.setProperty(lastIndex, "answer", generateFakeAnswer())
                            localChatModel.setProperty(lastIndex, "loading", false)
                        }
                    }
                }

                Component.onCompleted: {
                    if (projectData && !projectData.chatHistory) {
                        // Привязываем общую историю к текущему проекту
                        projectData.chatHistory = localChatModel
                    } else if (projectData && projectData.chatHistory) {
                        // Присваиваем существующую модель
                        for (var i = 0; i < projectData.chatHistory.count; i++) {
                            localChatModel.append(projectData.chatHistory.get(i))
                        }
                    }
                }

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 10

                    Label {
                        text: "AI-Ассистент • " + (projectData ? projectData.name : "")
                        font.pixelSize: 18
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 10

                        ListView {
                            id: chatView
                            model: localChatModel
                            spacing: 15

                            delegate: Column {
                                width: chatView.width
                                spacing: 8

                                Rectangle {
                                    width: parent.width * 0.7
                                    color: "#e3f2fd"
                                    radius: 10
                                    anchors.right: parent.right

                                    Text {
                                        text: model.question
                                        wrapMode: Text.Wrap
                                    }
                                }

                                Rectangle {
                                    width: parent.width * 0.7
                                    color: "#fff"
                                    radius: 10
                                    anchors.left: parent.left

                                    Text {
                                        text: model.loading ? "AI думает..." : model.answer
                                        wrapMode: Text.Wrap
                                    }
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        TextField {
                            id: messageInput
                            Layout.fillWidth: true
                            placeholderText: "Введите ваш вопрос..."
                        }

                        Button {
                            text: "Отправить"
                            onClicked: {
                                if (messageInput.text.trim() !== "") {
                                    localChatModel.append({
                                        question: messageInput.text,
                                        answer: "",
                                        loading: true
                                    })
                                    if (projectData) {
                                        projectData.chatHistory = localChatModel
                                    }
                                    messageInput.text = ""
                                    loadingTimer.start()
                                }
                            }
                        }
                    }

                    Rectangle {
                        visible: localChatModel.count > 0 && localChatModel.get(localChatModel.count - 1).loading
                        height: 20
                        width: 60
                        color: "transparent"
                        Row {
                            anchors.centerIn: parent
                            spacing: 5
                            Repeater {
                                model: 3
                                Rectangle {
                                    width: 8; height: 8; radius: 4
                                    color: "#4A90E2"
                                    SequentialAnimation on opacity {
                                        loops: Animation.Infinite
                                        NumberAnimation { from: 0.3; to: 1; duration: 300; easing.type: Easing.InOutQuad }
                                        PauseAnimation { duration: index * 100 }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }


    Component {
        id: statsScreen
        Rectangle {
            color: backgroundColor

            property var projectData: mainWindow.getProjectData(mainWindow.selectedProjectId)

            Grid {
                anchors.centerIn: parent
                columns: 2
                spacing: 25
                padding: 30

                Repeater {
                    model: [
                        {
                            icon: "data:image/svg+xml,%3Csvg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 4H7.2C6.0799 4 5.51984 4 5.09202 4.21799C4.71569 4.40974 4.40973 4.7157 4.21799 5.09202C4 5.51985 4 6.0799 4 7.2V16.8C4 17.9201 4 18.4802 4.21799 18.908C4.40973 19.2843 4.71569 19.5903 5.09202 19.782C5.51984 20 6.0799 20 7.2 20H16.8C17.9201 20 18.4802 20 18.908 19.782C19.2843 19.5903 19.5903 19.2843 19.782 18.908C20 18.4802 20 17.9201 20 16.8V12.5M15.5 5.5L18.3284 8.32843M10.7627 10.2373L17.411 3.58902C18.192 2.80797 19.4584 2.80797 20.2394 3.58902C21.0205 4.37007 21.0205 5.6364 20.2394 6.41745L13.3774 13.2794C12.6158 14.0411 12.235 14.4219 11.8012 14.7247C11.4162 14.9936 11.0009 15.2162 10.564 15.3882C10.0717 15.582 9.54378 15.6885 8.48793 15.9016L8 16L8.04745 15.6678C8.21536 14.4925 8.29932 13.9048 8.49029 13.3561C8.65975 12.8692 8.89125 12.4063 9.17906 11.9786C9.50341 11.4966 9.92319 11.0768 10.7627 10.2373Z' stroke='%23ffffff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E",
                            title: "Слова в сценарии",
                            value: projectData?.script?.split(/\s+/).length || 0
                        },
                        {
                            icon: "data:image/svg+xml,%3Csvg width='24' height='24' viewBox='0 0 512 512' fill='%23ffffff' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0,439.5h170.7V268.8H0V439.5z M42.7,311.5H128v85.3H42.7V311.5z M213.3,418.2H512v-42.7H213.3V418.2z M0,226.2h170.7V55.5 H0V226.2z M42.7,98.2H128v85.3H42.7V98.2z M213.3,76.8v42.7H512V76.8H213.3z M213.3,332.8H512v-42.7H213.3V332.8z M213.3,204.8H512 v-42.7H213.3V204.8z'/%3E%3C/svg%3E",
                            title: "Слова в заметках",
                            value: projectData?.notes?.split(/\s+/).length || 0
                        },
                        {
                            icon: "data:image/svg+xml,%3Csvg width='24' height='24' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M9 15C8.44771 15 8 15.4477 8 16C8 16.5523 8.44771 17 9 17C9.55229 17 10 16.5523 10 16C10 15.4477 9.55229 15 9 15Z' fill='%23ffffff'/%3E%3Cpath d='M14 16C14 15.4477 14.4477 15 15 15C15.5523 15 16 15.4477 16 16C16 16.5523 15.5523 17 15 17C14.4477 17 14 16.5523 14 16Z' fill='%23ffffff'/%3E%3Cpath fill-rule='evenodd' clip-rule='evenodd' d='M12 1C10.8954 1 10 1.89543 10 3C10 3.74028 10.4022 4.38663 11 4.73244V7H6C4.34315 7 3 8.34315 3 10V20C3 21.6569 4.34315 23 6 23H18C19.6569 23 21 21.6569 21 20V10C21 8.34315 19.6569 7 18 7H13V4.73244C13.5978 4.38663 14 3.74028 14 3C14 1.89543 13.1046 1 12 1ZM5 10C5 9.44772 5.44772 9 6 9H7.38197L8.82918 11.8944C9.16796 12.572 9.86049 13 10.618 13H13.382C14.1395 13 14.832 12.572 15.1708 11.8944L16.618 9H18C18.5523 9 19 9.44772 19 10V20C19 20.5523 18.5523 21 18 21H6C5.44772 21 5 20.5523 5 20V10ZM13.382 11L14.382 9H9.61803L10.618 11H13.382Z' fill='%23ffffff'/%3E%3Cpath d='M1 14C0.447715 14 0 14.4477 0 15V17C0 17.5523 0.447715 18 1 18C1.55228 18 2 17.5523 2 17V15C2 14.4477 1.55228 14 1 14Z' fill='%23ffffff'/%3E%3Cpath d='M22 15C22 14.4477 22.4477 14 23 14C23.5523 14 24 14.4477 24 15V17C24 17.5523 23.5523 18 23 18C22.4477 18 22 17.5523 22 17V15Z' fill='%23ffffff'/%3E%3C/svg%3E",
                            title: "Запросы к AI",
                            value: projectData?.chatHistory?.count || 0
                        },
                        {
                            icon: "data:image/svg+xml,%3Csvg width='24' height='24' viewBox='0 0 512 512' fill='%23ffffff' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M0,48v416h512V48H0z M228,88h56v32h-56V88z M92,424H36v-32h56V424z M92,120H36V88h56V120z M188,424h-56v-32h56V424z M188,120h-56V88h56V120z M284,424h-56v-32h56V424z M311.188,257.859l-92.156,55.016c-0.672,0.391-1.5,0.406-2.172,0.016s-1.094-1.094-1.094-1.891v-55v-55c0-0.781,0.422-1.5,1.094-1.875c0.672-0.391,1.5-0.375,2.172,0.016l92.156,55.016c0.656,0.375,1.047,1.094,1.047,1.844C312.234,256.766,311.844,257.469,311.188,257.859z M380,424h-56v-32h56V424z M380,120h-56V88h56V120z M476,424h-56v-32h56V424z M476,120h-56V88h56V120z'/%3E%3C/svg%3E",
                            title: "Кадры",
                            value: projectData?.storyboardItems?.count || 0
                        }
                    ]

                    delegate: Rectangle {
                        width: 280
                        height: 100
                        color: sectionColor
                        radius: 10

                        Row {
                            anchors.centerIn: parent
                            spacing: 15

                            Item {
                                width: 32
                                height: 32
                                anchors.verticalCenter: parent.verticalCenter

                                Image {
                                    source: modelData.icon
                                    width: 24
                                    height: 24
                                    anchors.centerIn: parent
                                }
                            }

                            Column {
                                spacing: 5
                                Text {
                                    text: modelData.title
                                    color: Qt.lighter(textColor, 1.2)
                                    font.pixelSize: 14
                                }
                                Text {
                                    text: modelData.value
                                    color: textColor
                                    font.pixelSize: 24
                                    font.bold: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function getComponent(title) {
        switch (title) {
            case "Проекты": return projectListScreen
            case "Синопсис": return settingsScreen
            case "Заметки": return notesScreen
            case "Текст": return scriptEditor
            case "Раскадровка": return storyboardScreen
             case "Статистика": return statsScreen
            case "AI-Ассистент": return assistantScreen
            default: return projectListScreen
        }
    }

    Component.onCompleted: {
        loadProjects()
        currentStage = "Проекты";
        screenLoader.sourceComponent = projectListScreen;
        mainWindow.closing.connect(saveProjects);
    }
}

import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import io.dtv.uisettings 1.0
import "."

Item {
    id: root
    Rectangle {
        color: "#161616"
        anchors.fill: parent
    }



    MouseArea {
        anchors.fill: parent
        onPressed: speedGauge.accelerating = true
        onReleased: speedGauge.accelerating = false
        onVisibleChanged: speedGauge.accelerating = false
    }

    Image {
        id: bgimage
        source: "qrc:/img/background.png"
        opacity: .25
        anchors.fill: parent
        mirror: true
    }

    Item {
        id: container
        width: root.width
        height: Math.max(root.width, root.height)
        anchors.centerIn: parent

        Row {
            id: gaugeRow
            spacing: container.width * 0.001
            anchors.centerIn: parent

            Item {
                width: height
                height: container.height * 0.35 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter

                TurnIndicator {
                    id: leftIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: height
                    height: parent.height / 5
                    direction: Qt.LeftArrow
                    on: Global.turnSignal === Qt.RightArrow
                }


                CircularGauge {
                    id: rpmGauge
                    minimumValue: 0
                    maximumValue: 8
                    value: 0.7 + (Global.gears * (maximumValue - 2) * (Global.speed-1) / Global.maxSpeed) % (maximumValue - 2)
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height / 2 - height / 3 - container.height * 0.01
                    width: parent.width
                    height: parent.height * 0.6
                    style: TachometerStyle {}

                    Behavior on value {
                        NumberAnimation {
                            duration: 120
                        }
                    }
                }
            }


            CircularGauge {
                id: speedGauge
                maximumValue: Global.maxSpeed
                value: accelerating ? maximumValue : 0
                width: height
                height: container.height * 0.4

                Behavior on value {
                    NumberAnimation {
                        duration: 15000

                    }
                }

                style: DashboardGaugeStyle {
                    unitsText: Global.metricUnits ? "km/h" : "mph"
                }

                property bool accelerating: false


                Keys.onSpacePressed: accelerating = true
                Keys.onReleased: {
                    if (event.key === Qt.Key_Space) {
                        accelerating = false;
                        event.accepted = true;
                    }
                }

                Component.onCompleted: forceActiveFocus()
            }


            Item {
                width: height
                height: container.height * 0.35 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter


                TurnIndicator {
                    id: rightIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: height
                    height: parent.height / 5

                    direction: Qt.RightArrow
                    on: Global.turnSignal === Qt.RightArrow
                }

                CircularGauge {
                    id: fuelGauge
                    value: Global.fuel
                    maximumValue: 1
                    y: parent.height / 2 - height / 2 - container.height * 0.01
                    width: parent.width
                    height: parent.height * 0.4

                    style: IconGaugeStyle {
                        id: fuelGaugeStyle

                        icon: "img/fuel-icon.png"
                        minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        }
                    }
                }

                CircularGauge {
                    value: Global.temperature
                    maximumValue: 1
                    width: parent.width
                    height: parent.height * 0.4
                    y: parent.height / 2 + container.height * 0.01

                    style: IconGaugeStyle {
                        id: tempGaugeStyle

                        icon: "img/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: blinkerTimer
        interval: 3000
        repeat: true
        running: true
        onTriggered: {
            Global.turnSignal = Math.random() < 0.5 ? -1 : Math.random() < 0.75 ? Qt.LeftArrow : Qt.RightArrow;

            if (Global.turnSignal === Qt.LeftArrow) {
                rightIndicator.on = false
                leftIndicator.on = true
            }
            else if (Global.turnSignal === Qt.RightArrow) {
                rightIndicator.on = true
                leftIndicator.on = false
            }
            else {
                rightIndicator.on = false
                leftIndicator.on = false
            }
        }
    }


    Connections {


        target: rpmGauge
        onValueChanged: {
            Global.rpm = rpmGauge.value

        }
    }
    Connections {
        target: speedGauge
        onValueChanged: {
            Global.speed = speedGauge.value
            Global.gear = !speedGauge.value ? "N" : parseInt(Global.gears*(speedGauge.value-1)/speedGauge.maximumValue+1).toString()
        }
    }

    UiSettings {
        id: uiSettings
    }

    Connections {
        target: Global
        onMetricUnitsChanged: {
        }
    }

    Connections {
        target: swipeView
        onIndexChanged: {
            speedGauge.accelerating = false
        }
    }
}

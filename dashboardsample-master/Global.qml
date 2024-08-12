pragma Singleton
import QtQuick 2.2


QtObject {
    id: global
    property string language: "en"
    property bool metricUnits: false
    property bool other: false


    property int turnSignal: -1
    property real fuel: .6
    property real temperature: 185 / 240
    property int speed: 0
    property int rpm: 0
    property string gear: "N"
    readonly property int gears: 6
    property int maxSpeed: metricUnits ? 240 : 160


    property string darkBlue: "#004a8d"
    property int fontSize: 24
}

//
// main.qml
//

import QtQuick 2.12
import QtQuick.Window 2.12

import SerialPortLib 1.0

Window {
    id: main

    visible: true
    width: 1280
    height: 480
    color: colorBackground
    title: qsTr("dashApp")

    property variant sourceData: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    property string colorNeedle:        "red"
    property string colorBackground:    "grey"

    property int    varSpeed:       sourceData[0]
    property int    varTacho:       sourceData[1]
    property real   varOdometr: 0//    sourceData[2]
    property real   varVoltage:     sourceData[2]
    property int    varFuel:        sourceData[3]
    property int    varCooliant:    sourceData[4]
    property real   varOutsideTemp: 0 //sourceData[6]
    property int    varOilPressure: sourceData[5]
    property int    varCheckEngine: sourceData[6]
    property int    varBatteryLow:  sourceData[7]
    property int    varBrakeWarn:   sourceData[8]
    property int    varABS:         sourceData[9]
    property int    varImmobilizer: sourceData[10]
    property int    varDoorAjar:    sourceData[11]
    property int    varTrunkLid:    sourceData[12]
    property int    varTurnLeft:    sourceData[13]
    property int    varTurnRight:   sourceData[14]
    property int    varHighBeam:    sourceData[15]
    property int    varFrontFog:    sourceData[16]
    property int    varAirBag:      sourceData[17]
    property int    varSeatBelt:    sourceData[18]

    // array sourceData received from Arduino
    / *
    === SENSORS ===
    0 speed
    1 engine speed
    2 odometer
    3 voltage on-board network
    4 fuel level
    5 coolant temperature
    6 outdoor temperature

    === LAMPS ===
    7 oil pressure
    8 check engine
    9 battery charge
    10 brakes
    11 ABS
    12 immobilizer
    13 the door is open
    14 trunk open
    15 left turn signal
    16 right turn signal
    17 high beam
    18 front tumanki
    19 AIR BAG
    20 seat belts
    * /


// load devices only after the panel mask loads
Loader {
        id: loader
        asynchronous: true
        active: false
        source: "qrc:/Dash.qml"

        Image{
            id: dashMask
            source: "qrc:/images/DashMask.png"
            Component.onCompleted: loader.active = true
        }
    }

    SerialPort {
        onSerial_data_Changed: {
            sourceData = "%1".arg(serial_data).split(',')
        }
    }


    // function is needed for icons
    // without it, zero is not perceived as FALSE
    function isVisible(value) {
        return value > 0;
    }
}

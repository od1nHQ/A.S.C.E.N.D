import QtQuick

Window {
    id: root

    property int pixelScale: 4
    property int bgWidth: 176
    property int bgHeight: 123

    // ===================== PLAN BUTTON POSITION =====================
    // Кнопка шаблона:
    // X більше  -> правіше
    // X менше   -> лівіше
    // Y більше  -> нижче
    // Y менше   -> вище
    property int planButtonX: 21
    property int planButtonY: 40
    property int planButtonSize: 18

    // ===================== SEQUENCE BUTTON POSITION =====================
    // Права кнопка для розрахунку/показу послідовності.
    //
    // За замовчуванням стоїть симетрично до planButton:
    // sequenceButtonX = bgWidth - planButtonX - planButtonSize
    //
    // sequenceButtonX більше -> кнопка правіше
    // sequenceButtonX менше  -> кнопка лівіше
    // sequenceButtonY більше -> кнопка нижче
    // sequenceButtonY менше  -> кнопка вище
    //
    // Поки використовує той самий icon, що і planButton.
    // Потім просто заміниш sequenceButtonIcon на свою PNG.
    property int sequenceButtonX: bgWidth - planButtonX - planButtonSize
    property int sequenceButtonY: planButtonY
    property int sequenceButtonSize: planButtonSize
    property string sequenceButtonIcon: "assets/ui/plan_icon.png"

    // ===================== SEQUENCE DROPDOWN SETTINGS =====================
    // Dropdown правої кнопки, де показується знайдена послідовність.
    //
    // sequenceDropdownOffsetX більше -> dropdown правіше
    // sequenceDropdownOffsetX менше  -> dropdown лівіше
    // sequenceDropdownOffsetY більше -> dropdown нижче
    // sequenceDropdownOffsetY менше  -> dropdown вище
    //
    // sequenceDropdownWidth / Height -> розмір панелі
    //
    // sequenceIconSize більше -> іконки послідовності більші
    // sequenceIconSize менше  -> іконки послідовності менші
    property bool sequenceDropdownVisible: false
    property var sequenceMoves: []
    property string sequenceMessage: ""

    property int sequenceDropdownOffsetX: 0
    property int sequenceDropdownOffsetY: 2
    property int sequenceDropdownWidth: 70
    property int sequenceDropdownHeight: 54

    property int sequenceTitleX: 3
    property int sequenceTitleY: 2
    property int sequenceGridX: 3
    property int sequenceGridY: 14

    property int sequenceIconSize: 10
    property int sequenceCellSize: 13
    property int sequenceCellSpacing: 2

    // ===================== FINAL MOVE SLOTS POSITION =====================
    // Три верхні рамки фінальних ударів.
    //
    // ВАЖЛИВО:
    // Розміри слотів тут НЕ задаються вручну.
    // Кожна PNG-картинка показується у своєму оригінальному розмірі,
    // тільки множиться на pixelScale.
    //
    // finalSlot1X / finalSlot1Y -> рухають ЛІВИЙ слот
    // finalSlot2X / finalSlot2Y -> рухають СЕРЕДНІЙ слот
    // finalSlot3X / finalSlot3Y -> рухають ПРАВИЙ слот
    //
    // X більше -> правіше
    // X менше  -> лівіше
    // Y більше -> нижче
    // Y менше  -> вище
    property int finalSlot1X: 59
    property int finalSlot1Y: 7

    property int finalSlot2X: 78
    property int finalSlot2Y: 7

    property int finalSlot3X: 97
    property int finalSlot3Y: 7

    property string finalSlot1Frame: "assets/ui/final_slots/final_slot_left.png"
    property string finalSlot2Frame: "assets/ui/final_slots/final_slot_middle.png"
    property string finalSlot3Frame: "assets/ui/final_slots/final_slot_right.png"

    // ===================== FINAL MOVE ICONS INSIDE SLOTS =====================
    // Це розмір іконки удару ВСЕРЕДИНІ верхнього слота.
    // На основні кнопки ходів внизу це не впливає.
    //
    // finalSlotIconSize більше -> іконка в слоті більша
    // finalSlotIconSize менше  -> іконка в слоті менша
    property int finalSlotIconSize: 10

    // Окреме зміщення іконки всередині кожного слота.
    //
    // IconOffsetX більше -> іконка правіше
    // IconOffsetX менше  -> іконка лівіше
    // IconOffsetY більше -> іконка нижче
    // IconOffsetY менше  -> іконка вище
    property int finalSlot1IconOffsetX: 0
    property int finalSlot1IconOffsetY: -3

    property int finalSlot2IconOffsetX: 0
    property int finalSlot2IconOffsetY: -2

    property int finalSlot3IconOffsetX: 0
    property int finalSlot3IconOffsetY: -1

    // Тут зберігаються вибрані фінальні ходи.
    // null = слот порожній.
    property var finalMoves: [null, null, null]

    // Який слот зараз відкрив dropdown.
    // -1 = dropdown закритий.
    property int openedFinalSlot: -1

    // ===================== FINAL MOVE DROPDOWN POSITION =====================
    // Dropdown прив’язаний до активного слота, але його можна підкрутити.
    //
    // dropdownOffsetX більше -> dropdown правіше
    // dropdownOffsetX менше  -> dropdown лівіше
    // dropdownOffsetY більше -> dropdown нижче
    // dropdownOffsetY менше  -> dropdown вище
    property int dropdownOffsetX: 0
    property int dropdownOffsetY: 20

    // Розмір самого dropdown.
    property int dropdownWidth: 74
    property int dropdownHeight: 39

    // Позиція grid всередині dropdown.
    property int dropdownGridX: 3
    property int dropdownGridY: 3

    // Розмір однієї іконки всередині dropdown.
    property int dropdownIconSize: 12
    property int dropdownCellSize: 15
    property int dropdownCellSpacing: 2

    // ===================== SCALE / MARKERS SETTINGS =====================

    // Межі шкали. У тебе вже підігнано як 0..146.
    property int minValue: 0
    property int maxValue: 146

    // Зелена стрілка статична. У грі вона стоїть на 0.
    property int startValue: 0

    // Червона стрілка = target/end position. Її можна рухати.
    property int targetValue: 113

    // ---------- ТВОЇ ВЖЕ ПІДІГНАНІ КООРДИНАТИ ШКАЛИ ----------
    // scaleStartX — позиція нуля по X.
    // scaleEndX   — кінець шкали по X.
    // scaleY      — базова висота шкали.
    //
    // scaleStartX більше -> вся ліва межа правіше
    // scaleStartX менше  -> вся ліва межа лівіше
    //
    // scaleEndX більше   -> права межа шкали правіше
    // scaleEndX менше    -> права межа шкали лівіше
    //
    // scaleY більше      -> обидві стрілки нижче
    // scaleY менше       -> обидві стрілки вище
    property int scaleStartX: 15
    property int scaleEndX: 162
    property int scaleY: 76

    // Розмір PNG-стрілок. Твої стрілки 5x5.
    property int markerSize: 5

    // Більше число = нижче.
    // Менше число = вище.
    property int greenMarkerYOffset: 24
    property int redMarkerYOffset: 18

    // Невидима зона кліку навколо червоної стрілки.
    // На вигляд не впливає.
    property int markerHitPadding: 4

    // Ширина шкали рахується автоматично.
    property int scaleBarWidth: scaleEndX - scaleStartX

    width: bgWidth * pixelScale
    height: bgHeight * pixelScale

    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height

    visible: true
    title: "A.S.C.E.N.D"

    color: "#000000"

    property var forgeMoves: [
        { value: -3,  icon: "assets/moves/-3.png" },
        { value: -6,  icon: "assets/moves/-6.png" },
        { value: 2,   icon: "assets/moves/+2.png" },
        { value: 7,   icon: "assets/moves/+7.png" },
        { value: -9,  icon: "assets/moves/-9.png" },
        { value: -15, icon: "assets/moves/-15.png" },
        { value: 13,  icon: "assets/moves/+13.png" },
        { value: 16,  icon: "assets/moves/+16.png" }
    ]

    // ===================== HELPER FUNCTIONS =====================

    function clamp(value, minLimit, maxLimit) {
        return Math.max(minLimit, Math.min(maxLimit, value))
    }

    function valueToX(value) {
        var clampedValue = clamp(value, minValue, maxValue)

        return (clampedValue - minValue)
               / (maxValue - minValue)
               * (scaleBarWidth * pixelScale)
    }

    function xToValue(xPosition) {
        var raw = minValue
                  + xPosition / (scaleBarWidth * pixelScale)
                  * (maxValue - minValue)

        return clamp(Math.round(raw), minValue, maxValue)
    }

    function markerX(value) {
        return scaleStartX * pixelScale
               + valueToX(value)
               - (markerSize * pixelScale) / 2
    }

    function updateTargetFromRootX(rootX) {
        var localX = rootX - scaleStartX * pixelScale

        localX = clamp(
            localX,
            0,
            scaleBarWidth * pixelScale
        )

        targetValue = xToValue(localX)

        console.log("Target:", targetValue)
    }

    function iconForMove(value) {
        for (var i = 0; i < forgeMoves.length; i++) {
            if (forgeMoves[i].value === value) {
                return forgeMoves[i].icon
            }
        }

        return ""
    }

    function setFinalMove(slotIndex, moveValue) {
        if (slotIndex < 0 || slotIndex >= 3) {
            return
        }

        var copy = finalMoves.slice()
        copy[slotIndex] = moveValue
        finalMoves = copy

        openedFinalSlot = -1

        console.log("Final moves:", finalMoves)
    }

    function clearFinalMove(slotIndex) {
        if (slotIndex < 0 || slotIndex >= 3) {
            return
        }

        var copy = finalMoves.slice()
        copy[slotIndex] = null
        finalMoves = copy

        openedFinalSlot = -1

        console.log("Final moves:", finalMoves)
    }

    function getCleanFinalMoves() {
        var clean = []

        for (var i = 0; i < finalMoves.length; i++) {
            if (finalMoves[i] !== null) {
                clean.push(finalMoves[i])
            }
        }

        return clean
    }

    function showSequenceError(message) {
        sequenceMoves = []
        sequenceMessage = message
        sequenceDropdownVisible = true
        console.log("Sequence error:", message)
    }

    function solveCurrentSequence() {
        openedFinalSlot = -1

        var cleanFinalMoves = getCleanFinalMoves()

        if (cleanFinalMoves.length < 1 || cleanFinalMoves.length > 3) {
            showSequenceError("Choose 1-3 final moves")
            return
        }

        if (typeof solverBridge === "undefined" || typeof solverBridge.solve !== "function") {
            showSequenceError("SolverBridge is not connected")
            return
        }

        var result = solverBridge.solve(
            root.startValue,
            root.targetValue,
            cleanFinalMoves
        )

        var path = []

        if (result.path !== undefined && result.path !== null) {
            for (var i = 0; i < result.path.length; i++) {
                path.push(result.path[i])
            }
        }

        sequenceMoves = path

        var steps = path.length

        if (result.steps !== undefined && result.steps !== null) {
            steps = result.steps
        }

        var msg = ""

        if (result.message !== undefined && result.message !== null && result.message !== "") {
            msg = result.message
        } else {
            msg = result.found ? "Sequence found" : "No sequence"
        }

        msg += " | steps: " + steps

        if (result.adjustedTarget !== undefined && result.adjustedTarget !== null) {
            msg += " | adj: " + result.adjustedTarget
        }

        sequenceMessage = msg
        sequenceDropdownVisible = true

        console.log("Solve:", sequenceMessage)
        console.log("Path:", sequenceMoves)
    }

    function finalSlotX(index) {
        if (index === 0) {
            return finalSlot1X
        }

        if (index === 1) {
            return finalSlot2X
        }

        return finalSlot3X
    }

    function finalSlotY(index) {
        if (index === 0) {
            return finalSlot1Y
        }

        if (index === 1) {
            return finalSlot2Y
        }

        return finalSlot3Y
    }

    function finalSlotFrame(index) {
        if (index === 0) {
            return finalSlot1Frame
        }

        if (index === 1) {
            return finalSlot2Frame
        }

        return finalSlot3Frame
    }

    function finalSlotIconOffsetX(index) {
        if (index === 0) {
            return finalSlot1IconOffsetX
        }

        if (index === 1) {
            return finalSlot2IconOffsetX
        }

        return finalSlot3IconOffsetX
    }

    function finalSlotIconOffsetY(index) {
        if (index === 0) {
            return finalSlot1IconOffsetY
        }

        if (index === 1) {
            return finalSlot2IconOffsetY
        }

        return finalSlot3IconOffsetY
    }

    // ===================== BACKGROUND =====================

    Image {
        id: anvilBackground

        anchors.fill: parent
        source: "assets/anvil_bg.png"

        fillMode: Image.Stretch
        smooth: false
    }

    // ===================== FINAL MOVE SLOT 1 =====================
    // Лівий слот.
    // Розмір не задається вручну.
    // Береться оригінальний розмір final_slot_left.png.

    Item {
        id: finalSlot1

        x: root.finalSlot1X * root.pixelScale
        y: root.finalSlot1Y * root.pixelScale

        width: finalSlot1FrameImage.implicitWidth * root.pixelScale
        height: finalSlot1FrameImage.implicitHeight * root.pixelScale

        z: 20

        property bool hasMove: root.finalMoves[0] !== null
        property int moveValue: hasMove ? root.finalMoves[0] : 0

        Image {
            id: finalSlot1FrameImage

            width: implicitWidth * root.pixelScale
            height: implicitHeight * root.pixelScale

            source: root.finalSlot1Frame
            smooth: false
            fillMode: Image.Stretch
        }

        Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.finalSlot1IconOffsetX * root.pixelScale
            anchors.verticalCenterOffset: root.finalSlot1IconOffsetY * root.pixelScale

            width: root.finalSlotIconSize * root.pixelScale
            height: root.finalSlotIconSize * root.pixelScale

            visible: finalSlot1.hasMove
            source: finalSlot1.hasMove ? root.iconForMove(finalSlot1.moveValue) : ""

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.RightButton) {
                    root.clearFinalMove(0)
                } else {
                    root.openedFinalSlot = root.openedFinalSlot === 0 ? -1 : 0
                    root.sequenceDropdownVisible = false
                }
            }
        }
    }

    // ===================== FINAL MOVE SLOT 2 =====================
    // Середній слот.
    // Розмір не задається вручну.
    // Береться оригінальний розмір final_slot_middle.png.

    Item {
        id: finalSlot2

        x: root.finalSlot2X * root.pixelScale
        y: root.finalSlot2Y * root.pixelScale

        width: finalSlot2FrameImage.implicitWidth * root.pixelScale
        height: finalSlot2FrameImage.implicitHeight * root.pixelScale

        z: 20

        property bool hasMove: root.finalMoves[1] !== null
        property int moveValue: hasMove ? root.finalMoves[1] : 0

        Image {
            id: finalSlot2FrameImage

            width: implicitWidth * root.pixelScale
            height: implicitHeight * root.pixelScale

            source: root.finalSlot2Frame
            smooth: false
            fillMode: Image.Stretch
        }

        Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.finalSlot2IconOffsetX * root.pixelScale
            anchors.verticalCenterOffset: root.finalSlot2IconOffsetY * root.pixelScale

            width: root.finalSlotIconSize * root.pixelScale
            height: root.finalSlotIconSize * root.pixelScale

            visible: finalSlot2.hasMove
            source: finalSlot2.hasMove ? root.iconForMove(finalSlot2.moveValue) : ""

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.RightButton) {
                    root.clearFinalMove(1)
                } else {
                    root.openedFinalSlot = root.openedFinalSlot === 1 ? -1 : 1
                    root.sequenceDropdownVisible = false
                }
            }
        }
    }

    // ===================== FINAL MOVE SLOT 3 =====================
    // Правий слот.
    // Розмір не задається вручну.
    // Береться оригінальний розмір final_slot_right.png.

    Item {
        id: finalSlot3

        x: root.finalSlot3X * root.pixelScale
        y: root.finalSlot3Y * root.pixelScale

        width: finalSlot3FrameImage.implicitWidth * root.pixelScale
        height: finalSlot3FrameImage.implicitHeight * root.pixelScale

        z: 20

        property bool hasMove: root.finalMoves[2] !== null
        property int moveValue: hasMove ? root.finalMoves[2] : 0

        Image {
            id: finalSlot3FrameImage

            width: implicitWidth * root.pixelScale
            height: implicitHeight * root.pixelScale

            source: root.finalSlot3Frame
            smooth: false
            fillMode: Image.Stretch
        }

        Image {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.finalSlot3IconOffsetX * root.pixelScale
            anchors.verticalCenterOffset: root.finalSlot3IconOffsetY * root.pixelScale

            width: root.finalSlotIconSize * root.pixelScale
            height: root.finalSlotIconSize * root.pixelScale

            visible: finalSlot3.hasMove
            source: finalSlot3.hasMove ? root.iconForMove(finalSlot3.moveValue) : ""

            smooth: false
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.RightButton) {
                    root.clearFinalMove(2)
                } else {
                    root.openedFinalSlot = root.openedFinalSlot === 2 ? -1 : 2
                    root.sequenceDropdownVisible = false
                }
            }
        }
    }

    // ===================== FINAL MOVE DROPDOWN =====================
    // Позиція dropdown прив’язана до відкритого слота.
    //
    // dropdownOffsetX більше -> dropdown правіше
    // dropdownOffsetX менше  -> dropdown лівіше
    // dropdownOffsetY більше -> dropdown нижче
    // dropdownOffsetY менше  -> dropdown вище

    Item {
        id: finalMoveDropdown

        visible: root.openedFinalSlot !== -1

        x: (root.finalSlotX(root.openedFinalSlot) + root.dropdownOffsetX) * root.pixelScale
        y: (root.finalSlotY(root.openedFinalSlot) + root.dropdownOffsetY) * root.pixelScale

        z: 200

        Rectangle {
            id: dropdownBackground

            width: root.dropdownWidth * root.pixelScale
            height: root.dropdownHeight * root.pixelScale

            color: "#1f1f1f"
            opacity: 0.94

            border.color: "#d08a2a"
            border.width: 1
        }

        Grid {
            id: dropdownGrid

            x: root.dropdownGridX * root.pixelScale
            y: root.dropdownGridY * root.pixelScale

            columns: 4
            spacing: root.dropdownCellSpacing * root.pixelScale

            Repeater {
                model: forgeMoves

                Item {
                    width: root.dropdownCellSize * root.pixelScale
                    height: root.dropdownCellSize * root.pixelScale

                    Rectangle {
                        anchors.fill: parent

                        color: dropdownMouseArea.containsMouse ? "#ffffff" : "transparent"
                        opacity: dropdownMouseArea.containsMouse ? 0.12 : 0.0
                    }

                    Image {
                        anchors.centerIn: parent

                        width: root.dropdownIconSize * root.pixelScale
                        height: root.dropdownIconSize * root.pixelScale

                        source: modelData.icon
                        smooth: false
                        fillMode: Image.PreserveAspectFit

                        scale: dropdownMouseArea.pressed ? 0.94
                               : dropdownMouseArea.containsMouse ? 1.08
                               : 1.0

                        Behavior on scale {
                            NumberAnimation {
                                duration: 45
                            }
                        }
                    }

                    MouseArea {
                        id: dropdownMouseArea

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            root.setFinalMove(root.openedFinalSlot, modelData.value)
                        }
                    }
                }
            }
        }
    }

    // ===================== GREEN START MARKER =====================
    // Статична зелена стрілка. Не перетягується.

    Image {
        id: greenMarker

        x: root.markerX(root.startValue)
        y: (root.scaleY + root.greenMarkerYOffset) * root.pixelScale

        width: root.markerSize * root.pixelScale
        height: root.markerSize * root.pixelScale

        source: "assets/ui/green_marker.png"
        smooth: false
        fillMode: Image.Stretch
    }

    // ===================== RED TARGET MARKER =====================
    // Рухома червона стрілка.

    Image {
        id: redMarker

        x: root.markerX(root.targetValue)
        y: (root.scaleY + root.redMarkerYOffset) * root.pixelScale

        width: root.markerSize * root.pixelScale
        height: root.markerSize * root.pixelScale

        source: "assets/ui/red_marker.png"
        smooth: false
        fillMode: Image.Stretch
    }

    Item {
        id: redMarkerHitArea

        x: redMarker.x - root.markerHitPadding * root.pixelScale
        y: redMarker.y - root.markerHitPadding * root.pixelScale

        width: (root.markerSize + root.markerHitPadding * 2) * root.pixelScale
        height: (root.markerSize + root.markerHitPadding * 2) * root.pixelScale

        MouseArea {
            id: redMarkerMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onPressed: function(mouse) {
                root.updateTargetFromRootX(redMarkerHitArea.x + mouse.x)
            }

            onPositionChanged: function(mouse) {
                if (pressed) {
                    root.updateTargetFromRootX(redMarkerHitArea.x + mouse.x)
                }
            }
        }
    }

    // ===================== PLAN BUTTON =====================
    // Ліва кнопка. Під майбутні шаблони.

    Item {
        id: planButton

        x: root.planButtonX * root.pixelScale
        y: root.planButtonY * root.pixelScale

        width: root.planButtonSize * root.pixelScale
        height: root.planButtonSize * root.pixelScale

        Image {
            id: planIcon

            anchors.centerIn: parent

            width: root.planButtonSize * root.pixelScale
            height: root.planButtonSize * root.pixelScale

            source: "assets/ui/plan_icon.png"
            smooth: false
            fillMode: Image.PreserveAspectFit

            scale: planMouseArea.pressed ? 0.96 : planMouseArea.containsMouse ? 1.035 : 1.0
            opacity: planMouseArea.containsMouse ? 1.0 : 0.96

            Behavior on scale {
                NumberAnimation {
                    duration: 55
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 55
                }
            }
        }

        MouseArea {
            id: planMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.sequenceDropdownVisible = false
                root.openedFinalSlot = -1
                console.log("Plan/template button clicked")
            }
        }
    }

    // ===================== SEQUENCE BUTTON =====================
    // Права кнопка. Тимчасово використовує той самий icon, що і planButton.
    // ЛКМ -> розрахувати sequence і відкрити sequence dropdown.

    Item {
        id: sequenceButton

        x: root.sequenceButtonX * root.pixelScale
        y: root.sequenceButtonY * root.pixelScale

        width: root.sequenceButtonSize * root.pixelScale
        height: root.sequenceButtonSize * root.pixelScale

        Image {
            id: sequenceIcon

            anchors.centerIn: parent

            width: root.sequenceButtonSize * root.pixelScale
            height: root.sequenceButtonSize * root.pixelScale

            source: root.sequenceButtonIcon
            smooth: false
            fillMode: Image.PreserveAspectFit

            scale: sequenceMouseArea.pressed ? 0.96 : sequenceMouseArea.containsMouse ? 1.035 : 1.0
            opacity: sequenceMouseArea.containsMouse ? 1.0 : 0.96

            Behavior on scale {
                NumberAnimation {
                    duration: 55
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 55
                }
            }
        }

        MouseArea {
            id: sequenceMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.solveCurrentSequence()
            }
        }
    }

    // ===================== SEQUENCE RESULT DROPDOWN =====================
    // Відкривається від правої кнопки.
    //
    // Позиція рахується так, щоб dropdown відкривався ліворуч від правої кнопки
    // і не вилазив за правий край GUI:
    //
    // x = sequenceButtonX + sequenceButtonSize - sequenceDropdownWidth + offset
    //
    // sequenceDropdownOffsetX / Y дозволяють точно підкрутити позицію.

    Item {
        id: sequenceResultDropdown

        visible: root.sequenceDropdownVisible

        x: (root.sequenceButtonX
            + root.sequenceButtonSize
            - root.sequenceDropdownWidth
            + root.sequenceDropdownOffsetX) * root.pixelScale

        y: (root.sequenceButtonY
            + root.sequenceButtonSize
            + root.sequenceDropdownOffsetY) * root.pixelScale

        width: root.sequenceDropdownWidth * root.pixelScale
        height: root.sequenceDropdownHeight * root.pixelScale

        z: 300

        Rectangle {
            anchors.fill: parent

            color: "#1f1f1f"
            opacity: 0.94

            border.color: "#d08a2a"
            border.width: 1
        }

        Text {
            id: sequenceTitle

            x: root.sequenceTitleX * root.pixelScale
            y: root.sequenceTitleY * root.pixelScale

            width: parent.width - 15 * root.pixelScale

            text: root.sequenceMessage
            color: "white"

            font.pixelSize: 4 * root.pixelScale
            elide: Text.ElideRight

            style: Text.Outline
            styleColor: "black"
        }

        Rectangle {
            id: sequenceCloseButton

            x: parent.width - 10 * root.pixelScale
            y: 2 * root.pixelScale

            width: 7 * root.pixelScale
            height: 7 * root.pixelScale

            color: sequenceCloseMouseArea.containsMouse ? "#4a1f1f" : "transparent"
            border.color: sequenceCloseMouseArea.containsMouse ? "#d08a2a" : "transparent"
            border.width: 1

            Text {
                anchors.centerIn: parent

                text: "x"
                color: "white"
                font.pixelSize: 4 * root.pixelScale
            }

            MouseArea {
                id: sequenceCloseMouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    root.sequenceDropdownVisible = false
                }
            }
        }

        Flickable {
            id: sequenceFlickable

            x: root.sequenceGridX * root.pixelScale
            y: root.sequenceGridY * root.pixelScale

            width: parent.width - 2 * root.sequenceGridX * root.pixelScale
            height: parent.height - root.sequenceGridY * root.pixelScale - 3 * root.pixelScale

            clip: true

            contentWidth: width
            contentHeight: sequenceFlow.implicitHeight

            Flow {
                id: sequenceFlow

                width: sequenceFlickable.width

                spacing: root.sequenceCellSpacing * root.pixelScale

                Repeater {
                    model: root.sequenceMoves

                    Item {
                        width: root.sequenceCellSize * root.pixelScale
                        height: root.sequenceCellSize * root.pixelScale

                        Image {
                            anchors.centerIn: parent

                            width: root.sequenceIconSize * root.pixelScale
                            height: root.sequenceIconSize * root.pixelScale

                            source: root.iconForMove(modelData)

                            smooth: false
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            anchors.centerIn: parent

                            visible: root.iconForMove(modelData) === ""

                            text: modelData
                            color: "white"
                            font.pixelSize: 4 * root.pixelScale

                            style: Text.Outline
                            styleColor: "black"
                        }
                    }
                }
            }
        }
    }

    // ===================== MOVE ICONS =====================

    Grid {
        id: moveIconsGrid

        columns: 4
        spacing: 2 * root.pixelScale

        // Позиція кнопок ходів:
        // X більше -> правіше
        // Y більше -> нижче
        x: 53 * root.pixelScale
        y: 50 * root.pixelScale

        Repeater {
            model: forgeMoves

            Item {
                id: moveCell

                width: 16 * root.pixelScale
                height: 16 * root.pixelScale

                Image {
                    id: moveIcon

                    anchors.centerIn: parent

                    width: 14 * root.pixelScale
                    height: 14 * root.pixelScale

                    source: modelData.icon
                    smooth: false
                    fillMode: Image.PreserveAspectFit

                    scale: mouseArea.pressed ? 0.96 : mouseArea.containsMouse ? 1.035 : 1.0
                    opacity: mouseArea.containsMouse ? 1.0 : 0.96

                    Behavior on scale {
                        NumberAnimation {
                            duration: 55
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 55
                        }
                    }
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        console.log("Clicked move:", modelData.value)
                    }
                }
            }
        }
    }
}

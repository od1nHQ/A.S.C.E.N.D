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

    // ===================== MODE BUTTON SETTINGS =====================
    // Кнопка перемикання режимів.
    //
    // manualMode = false -> CALC mode:
    //     move-кнопки НЕ рухають зелений marker;
    //     права кнопка рахує sequence через solver.
    //
    // manualMode = true -> MANUAL mode:
    //     move-кнопки рухають зелений marker;
    //     нижній ряд показує останні 3 натиснуті ходи;
    //     якщо останні ходи збігаються з finalMoves — нижній ряд світиться зеленим.
    property bool manualMode: false

    // Кнопка стоїть у верхньому лівому куті.
    //
    // modeButtonX більше -> правіше
    // modeButtonX менше  -> лівіше
    // modeButtonY більше -> нижче
    // modeButtonY менше  -> вище
    //
    // modeButtonSize     -> розмір кнопки
    // modeButtonIconSize -> розмір картинки всередині
    // modeButtonTextSize -> розмір напису CALC / MAN
    //
    // ЛКМ -> перемкнути CALC / MAN
    // ПКМ -> reset manual state
    property int modeButtonX: 5
    property int modeButtonY: 5
    property int modeButtonSize: 18
    property int modeButtonIconSize: 18
    property int modeButtonTextSize: 4

    // Поки використовуємо ту саму порожню іконку, що й для plan/sequence.
    // Якщо потім зробиш окрему PNG — просто заміниш цей шлях.
    property string modeButtonIcon: "assets/ui/plan_icon.png"

    // Зміщення напису всередині кнопки.
    //
    // modeButtonTextOffsetX більше -> текст правіше
    // modeButtonTextOffsetX менше  -> текст лівіше
    // modeButtonTextOffsetY більше -> текст нижче
    // modeButtonTextOffsetY менше  -> текст вище
    property int modeButtonTextOffsetX: 0
    property int modeButtonTextOffsetY: 0

    // ===================== MANUAL INPUT HISTORY SETTINGS =====================
    // Нижній ряд під final slots.
    // Він показує останні 3 ходи, які ти натиснув у MANUAL mode.
    //
    // manualSlot1X / manualSlot1Y -> лівий нижній слот
    // manualSlot2X / manualSlot2Y -> середній нижній слот
    // manualSlot3X / manualSlot3Y -> правий нижній слот
    //
    // X більше -> правіше
    // X менше  -> лівіше
    // Y більше -> нижче
    // Y менше  -> вище
    property int manualSlot1X: 60
    property int manualSlot1Y: 29

    property int manualSlot2X: 79
    property int manualSlot2Y: 29

    property int manualSlot3X: 98
    property int manualSlot3Y: 29

    // Розмір нижніх history-комірок.
    // Якщо іконки не вміщаються — крути manualSlotWidth / manualSlotHeight.
    property int manualSlotWidth: 17
    property int manualSlotHeight: 17

    // Окрема зелена підсвітка під нижніми слотами.
    // ВАЖЛИВО: це не рухає самі іконки, тільки зелену рамку/фон.
    //
    // manualHighlightOffsetX більше -> підсвітка правіше
    // manualHighlightOffsetX менше  -> підсвітка лівіше
    // manualHighlightOffsetY більше -> підсвітка нижче
    // manualHighlightOffsetY менше  -> підсвітка вище
    //
    // manualHighlightWidth / Height -> розмір зеленої підсвітки
    property int manualHighlightOffsetX: 4
    property int manualHighlightOffsetY: 2
    property int manualHighlightWidth: 10
    property int manualHighlightHeight: 10
    property real manualHighlightOpacity: 0.22

    // Іконка всередині нижнього slot history.
    property int manualSlotIconSize: 10

    // Зміщення іконок у нижньому ряду.
    property int manualSlotIconOffsetX: 0
    property int manualSlotIconOffsetY: -2

    // Історія натиснутих ходів у ручному режимі.
    property var pressedMoves: []

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

    function updateStartFromRootX(rootX) {
        var localX = rootX - scaleStartX * pixelScale

        localX = clamp(
            localX,
            0,
            scaleBarWidth * pixelScale
        )

        startValue = xToValue(localX)

        // Якщо в CALC mode руками перетягнули старт — історію ручних ходів чистимо,
        // бо це вже нова стартова точка.
        if (!manualMode) {
            pressedMoves = []
        }

        console.log("Start:", startValue)
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


    function resetManualState() {
        startValue = 0
        pressedMoves = []
        console.log("Manual state reset")
    }


    function setManualMode(value) {
        if (manualMode === value) {
            return
        }

        manualMode = value
        openedFinalSlot = -1
        sequenceDropdownVisible = false

        // Коли повертаємось у CALC mode — старт по дефолту знову 0.
        // Після цього його можна перетягнути зеленим marker-ом вручну.
        if (!manualMode) {
            resetManualState()
        }

        console.log("Mode:", manualMode ? "MANUAL" : "CALC")
    }

    function addPressedMove(moveValue) {
        pressedMoves = pressedMoves.concat([moveValue])

        // Щоб масив не ріс безкінечно. Для UI вистачить останніх 30 ходів.
        if (pressedMoves.length > 30) {
            pressedMoves = pressedMoves.slice(pressedMoves.length - 30)
        }

        console.log("Pressed moves:", pressedMoves)
    }

    function applyManualMove(moveValue) {
        var nextValue = startValue + moveValue

        startValue = clamp(nextValue, minValue, maxValue)
        addPressedMove(moveValue)

        sequenceDropdownVisible = false
        openedFinalSlot = -1

        console.log("Manual move:", moveValue)
        console.log("Current value:", startValue)
    }

    function manualSlotX(index) {
        if (index === 0) {
            return manualSlot1X
        }

        if (index === 1) {
            return manualSlot2X
        }

        return manualSlot3X
    }

    function manualSlotY(index) {
        if (index === 0) {
            return manualSlot1Y
        }

        if (index === 1) {
            return manualSlot2Y
        }

        return manualSlot3Y
    }

    function lastPressedMoveForSlot(slotIndex) {
        var result = [null, null, null]
        var start = Math.max(pressedMoves.length - 3, 0)
        var last = pressedMoves.slice(start)
        var offset = 3 - last.length

        for (var i = 0; i < last.length; i++) {
            result[offset + i] = last[i]
        }

        return result[slotIndex]
    }

    function finalSequenceMatchesInput() {
        var cleanFinal = getCleanFinalMoves()

        if (cleanFinal.length === 0) {
            return false
        }

        if (pressedMoves.length < cleanFinal.length) {
            return false
        }

        var last = pressedMoves.slice(pressedMoves.length - cleanFinal.length)

        for (var i = 0; i < cleanFinal.length; i++) {
            if (last[i] !== cleanFinal[i]) {
                return false
            }
        }

        return true
    }

    function manualSlotIsMatched(slotIndex) {
        var expectedMove = finalMoves[slotIndex]
        var actualMove = lastPressedMoveForSlot(slotIndex)

        if (expectedMove === null || actualMove === null) {
            return false
        }

        return expectedMove === actualMove
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


    // ===================== MODE BUTTON =====================
    // Кнопка перемикання CALC / MANUAL.
    //
    // ЛКМ -> перемкнути режим.
    // ПКМ -> reset manual state: зелений marker = 0, історія ходів очищена.
    //
    // Що крутити:
    // modeButtonX / modeButtonY              -> позиція
    // modeButtonSize                         -> розмір кнопки
    // modeButtonIconSize                     -> розмір картинки
    // modeButtonTextSize                     -> розмір напису
    // modeButtonTextOffsetX / OffsetY        -> зміщення напису
    //
    // Напис:
    // CALC = обчислювальний режим
    // MAN  = ручний режим

    Item {
        id: modeButton

        x: root.modeButtonX * root.pixelScale
        y: root.modeButtonY * root.pixelScale

        width: root.modeButtonSize * root.pixelScale
        height: root.modeButtonSize * root.pixelScale

        z: 250

        Image {
            id: modeButtonIconImage

            anchors.centerIn: parent

            width: root.modeButtonIconSize * root.pixelScale
            height: root.modeButtonIconSize * root.pixelScale

            source: root.modeButtonIcon
            smooth: false
            fillMode: Image.PreserveAspectFit

            scale: modeButtonMouseArea.pressed ? 0.96
                   : modeButtonMouseArea.containsMouse ? 1.035
                   : 1.0

            opacity: modeButtonMouseArea.containsMouse ? 1.0 : 0.96

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

        // Напис режиму поверх іконки.
        Text {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: root.modeButtonTextOffsetX * root.pixelScale
            anchors.verticalCenterOffset: root.modeButtonTextOffsetY * root.pixelScale

            text: root.manualMode ? "MAN" : "CALC"
            color: root.manualMode ? "#8cff8c" : "#ffd36a"

            font.pixelSize: root.modeButtonTextSize * root.pixelScale
            font.bold: true

            style: Text.Outline
            styleColor: "black"
        }

        // Малий індикатор у куті:
        // жовтий = CALC, зелений = MANUAL.
        Rectangle {
            x: parent.width - 4 * root.pixelScale
            y: parent.height - 4 * root.pixelScale

            width: 3 * root.pixelScale
            height: 3 * root.pixelScale

            color: root.manualMode ? "#43d15f" : "#d0a64a"
            border.color: "#111111"
            border.width: 1
        }

        MouseArea {
            id: modeButtonMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.RightButton) {
                    root.resetManualState()
                    return
                }

                root.setManualMode(!root.manualMode)
            }
        }
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


    // ===================== MANUAL INPUT HISTORY SLOTS =====================
    // Нижній ряд під final slots.
    //
    // Показує останні 3 ходи, які ти натиснув у MANUAL mode.
    //
    // Якщо останні 1/2/3 ходи збігаються з вибраними finalMoves,
    // відповідні праві нижні слоти світяться зеленим.

    Repeater {
        model: 3

        Item {
            id: manualHistorySlot

            x: root.manualSlotX(index) * root.pixelScale
            y: root.manualSlotY(index) * root.pixelScale

            width: root.manualSlotWidth * root.pixelScale
            height: root.manualSlotHeight * root.pixelScale

            z: 25

            property var moveValue: root.lastPressedMoveForSlot(index)
            property bool hasMove: moveValue !== null
            property bool matched: root.manualSlotIsMatched(index)

            Rectangle {
                x: root.manualHighlightOffsetX * root.pixelScale
                y: root.manualHighlightOffsetY * root.pixelScale

                width: root.manualHighlightWidth * root.pixelScale
                height: root.manualHighlightHeight * root.pixelScale

                color: manualHistorySlot.matched ? "#2cff5a" : "transparent"
                opacity: manualHistorySlot.matched ? root.manualHighlightOpacity : 0.0

                border.color: manualHistorySlot.matched ? "#2cff5a" : "transparent"
                border.width: manualHistorySlot.matched ? 1 : 0
            }

            Image {
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: root.manualSlotIconOffsetX * root.pixelScale
                anchors.verticalCenterOffset: root.manualSlotIconOffsetY * root.pixelScale

                width: root.manualSlotIconSize * root.pixelScale
                height: root.manualSlotIconSize * root.pixelScale

                visible: manualHistorySlot.hasMove
                source: manualHistorySlot.hasMove ? root.iconForMove(manualHistorySlot.moveValue) : ""

                smooth: false
                fillMode: Image.PreserveAspectFit
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

    // У CALC mode зелений marker можна перетягувати вручну як start position.
    // У MANUAL mode його рухають тільки move-кнопки.
    Item {
        id: greenMarkerHitArea

        x: greenMarker.x - root.markerHitPadding * root.pixelScale
        y: greenMarker.y - root.markerHitPadding * root.pixelScale

        width: (root.markerSize + root.markerHitPadding * 2) * root.pixelScale
        height: (root.markerSize + root.markerHitPadding * 2) * root.pixelScale

        z: 30

        MouseArea {
            id: greenMarkerMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.manualMode ? Qt.ArrowCursor : Qt.PointingHandCursor

            onPressed: function(mouse) {
                if (!root.manualMode) {
                    root.updateStartFromRootX(greenMarkerHitArea.x + mouse.x)
                }
            }

            onPositionChanged: function(mouse) {
                if (pressed && !root.manualMode) {
                    root.updateStartFromRootX(greenMarkerHitArea.x + mouse.x)
                }
            }
        }
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
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function(mouse) {
                if (mouse.button === Qt.RightButton) {
                    root.resetManualState()
                    root.sequenceDropdownVisible = false
                    return
                }

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
                        if (root.manualMode) {
                            root.applyManualMove(modelData.value)
                        } else {
                            console.log("Clicked move:", modelData.value)
                        }
                    }
                }
            }
        }
    }
}

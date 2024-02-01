package main

// import "core:fmt"
import "core:intrinsics"
import NS "vendor:darwin/Foundation"

main :: proc() {
    // fmt.println("Hello , mac world");

    NS.scoped_autoreleasepool()

    app := NS.Application.sharedApplication()
    app->setActivationPolicy(.Regular)

    menubar := NS.Menu.alloc()->init()
    app->setMainMenu(menubar)

    appMenuItem := NS.MenuItem.alloc()->init()
    menubar->addItem(appMenuItem)

    appMenu := NS.Menu.alloc()->init()
    appMenu->addItemWithTitle(
        NS.AT("Quit Test Program"),
        intrinsics.objc_find_selector("terminate"),
        NS.AT("q"),
    )
    appMenuItem->setSubmenu(appMenu)

    windowRectangle := NS.Rect {{0.0, 0.0}, {600.0, 600.0}}
    window := NS.Window.alloc()->initWithContentRect(
        windowRectangle,
        {.Titled, .Closable},
        NS.BackingStoreType.Buffered,
        false,
    )

    window->setTitle(NS.AT("TestProgram"))
    window->makeKeyAndOrderFront(nil)

    app->run()
}
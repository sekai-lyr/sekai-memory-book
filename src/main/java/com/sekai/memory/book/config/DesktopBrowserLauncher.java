package com.sekai.memory.book.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.awt.Desktop;
import java.net.URI;

@Component
@Profile("desktop")
public class DesktopBrowserLauncher {

    @Value("${server.port:18083}")
    private int port;

    @Value("${sekai.desktop.open-browser:true}")
    private boolean openBrowser;

    @EventListener(ApplicationReadyEvent.class)
    public void openBrowser() {
        if (!openBrowser || !Desktop.isDesktopSupported()) {
            return;
        }
        try {
            Desktop.getDesktop().browse(URI.create("http://localhost:" + port + "/home"));
        } catch (Exception ignored) {
            // The packaged app still starts even if Windows blocks browser automation.
        }
    }
}

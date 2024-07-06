// ==UserScript==
// @name         Google Classroom Drive Attachment Downloader
// @namespace    http://tampermonkey.net/
// @version      2.0
// @description  Creates a scrollable download panel for Google Drive attachments in Google Classroom
// @match        https://classroom.google.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    let panelCreated = false;
    let canCreatePanel = true;
    let observer;

    function createDownloadPanel() {
        if (panelCreated || !canCreatePanel) return;
        console.log('Attempting to create download panel...');

        const attachments = Array.from(document.querySelectorAll('a'))
            .filter((a) => {
                const ariaLabel = a.getAttribute('aria-label') ?? '';
                const href = a.getAttribute('href') ?? '';
                return ariaLabel.startsWith('Attachment:') && href.includes('drive.google.com');
            });

        console.log(`Found ${attachments.length} attachments`);

        if (attachments.length === 0) {
            console.log('No attachments found, not creating panel.');
            return;
        }

        // Create container for download links
        const container = document.createElement('div');
        container.style.position = 'fixed';
        container.style.top = '10px';
        container.style.right = '10px';
        container.style.backgroundColor = 'white';
        container.style.padding = '10px';
        container.style.border = '1px solid black';
        container.style.zIndex = '9999';
        container.style.maxHeight = '80vh';
        container.style.overflowY = 'auto';
        container.style.width = '250px';

        // Add close button
        const closeButton = document.createElement('button');
        closeButton.textContent = 'X';
        closeButton.style.position = 'sticky';
        closeButton.style.top = '0';
        closeButton.style.right = '0';
        closeButton.style.cursor = 'pointer';
        closeButton.style.zIndex = '1';
        closeButton.style.backgroundColor = 'white';
        closeButton.onclick = () => {
            document.body.removeChild(container);
            panelCreated = false;
            canCreatePanel = false;
            if (observer) {
                observer.observe(document.body, { childList: true, subtree: true });
            }
            setTimeout(() => {
                canCreatePanel = true;
            }, 1000); // Wait 1 second before allowing panel creation again
        };
        container.appendChild(closeButton);

        // Create a scrollable content div
        const contentDiv = document.createElement('div');
        contentDiv.style.marginTop = '20px';
        container.appendChild(contentDiv);

        // Process links and create download buttons
        const downloadLinks = attachments.map((a) => {
            const href = a.getAttribute('href');
            const match = href.match(/\/d\/(.+?)\//);
            if (match && match[1]) {
                return {
                    originalUrl: href,
                    downloadUrl: `https://drive.google.com/uc?export=download&id=${match[1]}&authuser=0`,
                    fileName: a.textContent.trim().replace(/\.[^/.]+$/, '')
                };
            }
            return null;
        }).filter(link => link !== null);

        // Create download buttons for each link
        downloadLinks.forEach((link, index) => {
            const button = document.createElement('button');
            button.textContent = link.fileName || `File ${index + 1}`;
            button.style.display = 'block';
            button.style.margin = '5px 0';
            button.style.width = '100%';
            button.style.textAlign = 'left';
            button.style.overflow = 'hidden';
            button.style.textOverflow = 'ellipsis';
            button.style.whiteSpace = 'nowrap';
            button.onclick = () => window.open(link.downloadUrl, '_blank');
            contentDiv.appendChild(button);
        });

        // Append the container to the document body
        document.body.appendChild(container);

        console.log('Download panel created successfully.');
        panelCreated = true;
        if (observer) {
            observer.disconnect(); // Stop observing when panel is created
        }
    }

    function checkForAttachments() {
        if (document.querySelector('a[aria-label^="Attachment:"]')) {
            createDownloadPanel();
        }
    }

    // Use MutationObserver to detect when new content is loaded
    observer = new MutationObserver((mutations) => {
        if (!panelCreated && canCreatePanel) {
            checkForAttachments();
        }
    });

    // Function to initialize or reset the script
    function initializeScript() {
        panelCreated = false;
        canCreatePanel = true;
        if (observer) {
            observer.disconnect();
        }
        observer.observe(document.body, { childList: true, subtree: true });
        checkForAttachments();
    }

    // Run on initial page load and subsequent navigations
    if (document.readyState === 'complete') {
        initializeScript();
    } else {
        window.addEventListener('load', initializeScript);
    }

    // Reset script state on page unload (for single-page app navigation)
    window.addEventListener('beforeunload', () => {
        panelCreated = false;
        canCreatePanel = true;
    });
})();

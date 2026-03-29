// on the page of a YouTube playlist, run this command to delete videos from the list
(async function() {
    const n = parseInt(prompt('Enter the number of videos to remove from the playlist:'), 10);
    if (isNaN(n)) return;
    if (n <= 0) {
        alert('Please enter a valid positive number');
        return;
    }

    for (let i = 0; i < n; i++) {
        const btn1 = document.querySelectorAll('#button > .yt-icon-button.style-scope')[3];
        if (!btn1) {
            alert('1st button not found.');
            return;
        }
        btn1.click();
        await new Promise(resolve => setTimeout(resolve, 120));

        const btn2 = document.querySelector(
            'ytd-menu-service-item-renderer.ytd-menu-popup-renderer.style-scope:nth-of-type(3)');
        if (!btn2) {
            alert('2nd button not found.');
            return;
        }
        btn2.click();

        await new Promise(resolve => setTimeout(resolve, 400));
    }
})();

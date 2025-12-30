class MatrixRain {
    constructor(canvas) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*ｱｲｳｴｵｶｷｸｹｺ';
        this.fontSize = 14;
        this.resize();
        window.addEventListener('resize', () => this.resize());
    }
    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
        this.columns = Math.floor(this.canvas.width / this.fontSize);
        this.drops = Array(this.columns).fill(1);
    }
    draw() {
        this.ctx.fillStyle = 'rgba(10, 10, 10, 0.05)';
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
        this.ctx.fillStyle = '#00ff41';
        this.ctx.font = this.fontSize + 'px monospace';
        for (let i = 0; i < this.drops.length; i++) {
            const char = this.chars[Math.floor(Math.random() * this.chars.length)];
            this.ctx.fillText(char, i * this.fontSize, this.drops[i] * this.fontSize);
            if (this.drops[i] * this.fontSize > this.canvas.height && Math.random() > 0.975) this.drops[i] = 0;
            this.drops[i]++;
        }
    }
    start() { setInterval(() => this.draw(), 50); }
}

class BootSequence {
    constructor() {
        this.lines = document.querySelectorAll('.boot-line');
        this.mainContent = document.getElementById('main-content');
    }
    async start() {
        for (const line of this.lines) {
            await this.sleep(300);
            line.classList.add('visible');
        }
        await this.sleep(500);
        this.mainContent.classList.remove('hidden');
    }
    sleep(ms) { return new Promise(resolve => setTimeout(resolve, ms)); }
}

function connectToTerminal() {
    const overlay = document.createElement('div');
    overlay.className = 'loading-overlay';
    overlay.innerHTML = '<div class="loading-text">Connecting...</div><div class="loading-bar"></div>';
    document.body.appendChild(overlay);
    requestAnimationFrame(() => overlay.classList.add('active'));
    setTimeout(() => { window.location.href = '/terminal/'; }, 2000);
}

document.addEventListener('DOMContentLoaded', () => {
    const canvas = document.getElementById('matrix-rain');
    if (canvas) new MatrixRain(canvas).start();
    new BootSequence().start();
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' && !document.getElementById('main-content').classList.contains('hidden')) {
            connectToTerminal();
        }
    });
    console.log('%c NIMBUS TECHNOLOGIES ', 'background: #00ff41; color: #000; font-size: 20px;');
    console.log('%c Figure it out. - Kevin ', 'color: #ffb000; font-style: italic;');
});

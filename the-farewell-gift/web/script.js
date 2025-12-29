/* =====================================================
   THE FAREWELL GIFT - NIMBUS TECHNOLOGIES CTF
   Boot Sequence & Effects JavaScript
   ===================================================== */

// =====================================================
// MATRIX RAIN EFFECT
// =====================================================

class MatrixRain {
    constructor(canvas) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()_+-=[]{}|;:,.<>?~`ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜﾝ';
        this.fontSize = 14;
        this.columns = 0;
        this.drops = [];

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
        // Semi-transparent black to create fade effect
        this.ctx.fillStyle = 'rgba(10, 10, 10, 0.05)';
        this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);

        this.ctx.fillStyle = '#00ff41';
        this.ctx.font = this.fontSize + 'px monospace';

        for (let i = 0; i < this.drops.length; i++) {
            const char = this.chars[Math.floor(Math.random() * this.chars.length)];
            const x = i * this.fontSize;
            const y = this.drops[i] * this.fontSize;

            this.ctx.fillText(char, x, y);

            // Reset drop to top randomly
            if (y > this.canvas.height && Math.random() > 0.975) {
                this.drops[i] = 0;
            }

            this.drops[i]++;
        }
    }

    start() {
        setInterval(() => this.draw(), 50);
    }
}

// =====================================================
// BOOT SEQUENCE ANIMATION
// =====================================================

class BootSequence {
    constructor() {
        this.lines = document.querySelectorAll('.boot-line');
        this.mainContent = document.getElementById('main-content');
        this.currentLine = 0;
    }

    async start() {
        for (const line of this.lines) {
            const delay = parseInt(line.dataset.delay) || 0;
            await this.sleep(delay > 0 ? 400 : 0);

            // Animate dots if present
            const dots = line.querySelector('.dots');
            if (dots) {
                line.classList.add('visible');
                await this.animateDots(dots);
            } else {
                line.classList.add('visible');
            }
        }

        // Show main content after boot sequence
        await this.sleep(800);
        this.showMainContent();
    }

    async animateDots(dotsElement) {
        return new Promise(resolve => {
            setTimeout(resolve, 600);
        });
    }

    showMainContent() {
        this.mainContent.classList.remove('hidden');

        // Add a subtle entrance effect
        this.mainContent.style.opacity = '0';
        this.mainContent.style.transform = 'translateY(20px)';

        requestAnimationFrame(() => {
            this.mainContent.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            this.mainContent.style.opacity = '1';
            this.mainContent.style.transform = 'translateY(0)';
        });
    }

    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// =====================================================
// TYPEWRITER EFFECT (for extra flair)
// =====================================================

class Typewriter {
    constructor(element, text, speed = 50) {
        this.element = element;
        this.text = text;
        this.speed = speed;
        this.currentIndex = 0;
    }

    async type() {
        return new Promise(resolve => {
            const interval = setInterval(() => {
                if (this.currentIndex < this.text.length) {
                    this.element.textContent += this.text[this.currentIndex];
                    this.currentIndex++;
                } else {
                    clearInterval(interval);
                    resolve();
                }
            }, this.speed);
        });
    }
}

// =====================================================
// TERMINAL CONNECTION
// =====================================================

function connectToTerminal() {
    // Play beep sound if available
    const beep = document.getElementById('beep-sound');
    if (beep) {
        beep.currentTime = 0;
        beep.play().catch(() => {}); // Ignore autoplay errors
    }

    // Create loading overlay
    const overlay = document.createElement('div');
    overlay.className = 'loading-overlay';
    overlay.innerHTML = `
        <div class="loading-text">Connecting to debug terminal...</div>
        <div class="loading-bar"></div>
    `;
    document.body.appendChild(overlay);

    // Activate overlay
    requestAnimationFrame(() => {
        overlay.classList.add('active');
    });

    // Redirect to ttyd terminal after animation
    setTimeout(() => {
        window.location.href = '/terminal/';
    }, 2500);
}

// =====================================================
// RANDOM FLICKER EFFECT
// =====================================================

function randomFlicker() {
    const crt = document.querySelector('.crt');
    if (!crt) return;

    setInterval(() => {
        if (Math.random() > 0.97) {
            crt.style.opacity = '0.8';
            setTimeout(() => {
                crt.style.opacity = '1';
            }, 50);
        }
    }, 100);
}

// =====================================================
// CURSOR TRAIL EFFECT (subtle)
// =====================================================

function initCursorEffect() {
    const cursor = document.createElement('div');
    cursor.style.cssText = `
        position: fixed;
        width: 10px;
        height: 10px;
        background: rgba(0, 255, 65, 0.3);
        border-radius: 50%;
        pointer-events: none;
        z-index: 9999;
        transition: transform 0.1s ease;
        mix-blend-mode: screen;
    `;
    document.body.appendChild(cursor);

    document.addEventListener('mousemove', (e) => {
        cursor.style.left = e.clientX - 5 + 'px';
        cursor.style.top = e.clientY - 5 + 'px';
    });
}

// =====================================================
// INITIALIZATION
// =====================================================

document.addEventListener('DOMContentLoaded', () => {
    // Initialize Matrix Rain
    const canvas = document.getElementById('matrix-rain');
    if (canvas) {
        const matrix = new MatrixRain(canvas);
        matrix.start();
    }

    // Start boot sequence
    const bootSequence = new BootSequence();
    bootSequence.start();

    // Initialize random flicker
    randomFlicker();

    // Initialize cursor effect (optional - can be removed if too distracting)
    // initCursorEffect();

    // Add keyboard shortcut to connect (Enter key)
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            const mainContent = document.getElementById('main-content');
            if (mainContent && !mainContent.classList.contains('hidden')) {
                connectToTerminal();
            }
        }
    });

    // Console easter egg
    console.log('%c NIMBUS TECHNOLOGIES ', 'background: #00ff41; color: #000; font-size: 20px; font-weight: bold;');
    console.log('%c Debug Terminal Active ', 'color: #00ff41; font-size: 14px;');
    console.log('%c "skill issue" - Kevin ', 'color: #ffb000; font-style: italic;');
});

// =====================================================
// ADDITIONAL EFFECTS
// =====================================================

// Screen shake on certain events
function screenShake() {
    const container = document.querySelector('.crt-container');
    container.style.animation = 'none';
    container.offsetHeight; // Trigger reflow
    container.style.animation = 'shake 0.5s ease';
}

// Add shake keyframes dynamically
const style = document.createElement('style');
style.textContent = `
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        10%, 30%, 50%, 70%, 90% { transform: translateX(-2px); }
        20%, 40%, 60%, 80% { transform: translateX(2px); }
    }
`;
document.head.appendChild(style);

// Export for potential external use
window.NimbusTerminal = {
    connectToTerminal,
    screenShake
};

const panel = document.getElementById('medical-status');
const title = document.getElementById('title');
const message = document.getElementById('message');
const timer = document.getElementById('timer');
const hint = document.getElementById('hint');
const formatTime = seconds => `${String(Math.max(0, Math.floor(seconds / 60))).padStart(2, '0')}:${String(Math.max(0, seconds % 60)).padStart(2, '0')}`;

window.addEventListener('message', ({ data }) => {
  if (data.action === 'hide') panel.classList.remove('visible');
  if (data.action === 'show') panel.classList.add('visible');
  if (data.action === 'update' || data.action === 'show') {
    const dead = data.status === 'deceased';
    title.textContent = dead ? 'You are deceased' : 'Critical condition';
    message.textContent = dead ? 'You have been incapacitated. Await assistance or respawn.' : 'Stay calm. Medical assistance has been alerted.';
    timer.textContent = formatTime(Number(data.seconds) || 0);
    hint.style.display = dead ? 'flex' : 'none';
  }
});

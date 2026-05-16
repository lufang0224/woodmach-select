document.addEventListener("click", (event) => {
  const link = event.target.closest(".lightbox-link");
  if (!link) return;
  event.preventDefault();

  const overlay = document.createElement("div");
  overlay.className = "image-overlay";
  overlay.innerHTML = `<button type="button" aria-label="Close">x</button><img src="${link.href}" alt="">`;
  document.body.appendChild(overlay);

  overlay.addEventListener("click", () => overlay.remove());
});

const style = document.createElement("style");
style.textContent = `
  .image-overlay {
    position: fixed;
    inset: 0;
    z-index: 100;
    display: grid;
    place-items: center;
    padding: 24px;
    background: rgba(0, 0, 0, .86);
  }
  .image-overlay img {
    max-height: 92vh;
    max-width: 96vw;
    border-radius: 8px;
  }
  .image-overlay button {
    position: fixed;
    top: 18px;
    right: 18px;
    width: 42px;
    height: 42px;
    border: 0;
    border-radius: 50%;
    background: #fff;
    color: #16211f;
    font-size: 22px;
    cursor: pointer;
  }
`;
document.head.appendChild(style);

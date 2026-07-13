# How To Update My Website

Print this and keep it next to the computer.

## First time only (setup)

1. In GitHub Desktop, clone the website to this computer.
2. In the website folder, right-click **setup-windows.ps1** and choose
   **Run with PowerShell**. Click **Yes** if Windows asks.
3. Wait for it to say **All done**. You never do this step again.

## To change or add something

1. Open the website folder in **VSCode**.
2. Open a page. Pages end in `.qmd`.
   - Home page is `index.qmd`
   - Notes are in the `notes` folder
3. To watch your changes live, click **Preview** (top right in VSCode).
   A page opens in the browser and updates as you type.
4. Edit the words. Save with **Ctrl + S**.

## To add a brand-new note

1. In the `notes` folder, make a copy of `first-note.qmd`.
2. Rename the copy (for example `week-two.qmd`).
3. Change the title and the words inside.
   It will show up on the Notes page by itself.

## To publish (make it live on the internet)

1. In the website folder, **double-click `render.bat`**. A black window opens,
   builds the site, and says **Done**. Close it.
2. Open **GitHub Desktop**.
   - Type a short note in the **Summary** box (example: "added week two").
   - Click **Commit to main**.
   - Click **Push origin**.
3. Wait about **one minute**, then refresh my website. Done.

## Good to know

- After you run `render.bat`, GitHub Desktop may show **many** changed files.
  That is normal. Just commit them all.
- Always run `render.bat` before you push. If you forget, the website will
  not show your new changes.
- Writing math: put it between dollar signs. Example: `$E = mc^2$`.
- Pages can also draw charts with a little Python. See `example-with-a-plot`
  in the `notes` folder for a pattern to copy.
- This sheet assumes a Windows computer. On a Mac or Linux computer, the
  setup script is `setup-mac.sh` or `setup-linux.sh`, and you rebuild with
  `bash render.sh` in a terminal instead of `render.bat`.

## If something looks broken

- Close and reopen VSCode.
- Make sure you ran `render.bat` before pushing.
- If a chart did not appear, run `render.bat` again. The first run after setup
  sometimes needs a second try.
- Call [your name] if still stuck.

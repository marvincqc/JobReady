"use strict";

const express = require("express");
const path    = require("path");
require("dotenv").config();

const { generateAndStorePDF } = require("./pdf");

const app = express();

// ─── Serve public folder (web wizard) ─────────────────────────────────────────
app.use(express.static(path.join(__dirname, "../public")));
app.use(express.json());

// ─── Health check (used by cron keepalive) ────────────────────────────────────
app.get("/health", (_req, res) => res.json({ status: "ok" }));

// ─── Privacy policy ───────────────────────────────────────────────────────────
app.get("/privacy", (_req, res) =>
  res.sendFile(path.join(__dirname, "../public/privacy.html"))
);

// ─── Web wizard submit ────────────────────────────────────────────────────────
app.post("/submit", async (req, res) => {
  const { data } = req.body;
  if (!data) return res.status(400).json({ ok: false, error: "No data provided" });

  try {
    const submissionId = "web-" + Date.now();
    const pdfUrl = await generateAndStorePDF(data, submissionId);
    console.log(`✅ Submission: ${data.name} → ${data.agency}`);
    res.json({ ok: true, pdfUrl });
  } catch (err) {
    console.error("Submit error:", err.message);
    res.status(500).json({ ok: false, error: err.message });
  }
});

// ─── Start ─────────────────────────────────────────────────────────────────────
const PORT = process.env.PORT || 10000;
app.listen(PORT, () => console.log(`🚀 StartJobReady listening on port ${PORT}`));

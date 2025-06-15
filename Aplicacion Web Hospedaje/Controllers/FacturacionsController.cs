using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Aplicacion_Web_Hospedaje.Models;

namespace Aplicacion_Web_Hospedaje.Controllers
{
    public class FacturacionsController : Controller
    {
        private readonly AppDbContext _context;

        public FacturacionsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Facturacions
        public async Task<IActionResult> Index()
        {
            var appDbContext = _context.Facturacions.Include(f => f.IdReservaNavigation).Include(f => f.IdTipoPagoNavigation);
            return View(await appDbContext.ToListAsync());
        }

        // GET: Facturacions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var facturacion = await _context.Facturacions
                .Include(f => f.IdReservaNavigation)
                .Include(f => f.IdTipoPagoNavigation)
                .FirstOrDefaultAsync(m => m.IdFactura == id);
            if (facturacion == null)
            {
                return NotFound();
            }

            return View(facturacion);
        }

        // GET: Facturacions/Create
        public IActionResult Create()
        {
            ViewData["IdReserva"] = new SelectList(_context.Reservacions, "IdReserva", "IdReserva");
            ViewData["IdTipoPago"] = new SelectList(_context.TipoPagos, "IdTipoPago", "IdTipoPago");
            return View();
        }

        // POST: Facturacions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdFactura,NumeroFacturacion,IdReserva,FechaEmision,CantidadNoches,ImporteTotal,IdTipoPago,Estado")] Facturacion facturacion)
        {
            if (ModelState.IsValid)
            {
                _context.Add(facturacion);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdReserva"] = new SelectList(_context.Reservacions, "IdReserva", "IdReserva", facturacion.IdReserva);
            ViewData["IdTipoPago"] = new SelectList(_context.TipoPagos, "IdTipoPago", "IdTipoPago", facturacion.IdTipoPago);
            return View(facturacion);
        }

        // GET: Facturacions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var facturacion = await _context.Facturacions.FindAsync(id);
            if (facturacion == null)
            {
                return NotFound();
            }
            ViewData["IdReserva"] = new SelectList(_context.Reservacions, "IdReserva", "IdReserva", facturacion.IdReserva);
            ViewData["IdTipoPago"] = new SelectList(_context.TipoPagos, "IdTipoPago", "IdTipoPago", facturacion.IdTipoPago);
            return View(facturacion);
        }

        // POST: Facturacions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdFactura,NumeroFacturacion,IdReserva,FechaEmision,CantidadNoches,ImporteTotal,IdTipoPago,Estado")] Facturacion facturacion)
        {
            if (id != facturacion.IdFactura)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(facturacion);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FacturacionExists(facturacion.IdFactura))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdReserva"] = new SelectList(_context.Reservacions, "IdReserva", "IdReserva", facturacion.IdReserva);
            ViewData["IdTipoPago"] = new SelectList(_context.TipoPagos, "IdTipoPago", "IdTipoPago", facturacion.IdTipoPago);
            return View(facturacion);
        }

        // GET: Facturacions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var facturacion = await _context.Facturacions
                .Include(f => f.IdReservaNavigation)
                .Include(f => f.IdTipoPagoNavigation)
                .FirstOrDefaultAsync(m => m.IdFactura == id);
            if (facturacion == null)
            {
                return NotFound();
            }

            return View(facturacion);
        }

        // POST: Facturacions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var facturacion = await _context.Facturacions.FindAsync(id);
            if (facturacion != null)
            {
                _context.Facturacions.Remove(facturacion);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool FacturacionExists(int id)
        {
            return _context.Facturacions.Any(e => e.IdFactura == id);
        }
    }
}

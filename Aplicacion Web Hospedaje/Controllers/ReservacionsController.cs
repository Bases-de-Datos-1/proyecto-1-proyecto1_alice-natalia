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
    public class ReservacionsController : Controller
    {
        private readonly AppDbContext _context;

        public ReservacionsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Reservacions
        public async Task<IActionResult> Index()
        {
            var appDbContext = _context.Reservacions.Include(r => r.IdClienteNavigation).Include(r => r.IdHabitacionNavigation);
            return View(await appDbContext.ToListAsync());
        }

        // GET: Reservacions/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var reservacion = await _context.Reservacions
                .Include(r => r.IdClienteNavigation)
                .Include(r => r.IdHabitacionNavigation)
                .FirstOrDefaultAsync(m => m.IdReserva == id);
            if (reservacion == null)
            {
                return NotFound();
            }

            return View(reservacion);
        }

        // GET: Reservacions/Create
        public IActionResult Create()
        {
            ViewData["IdCliente"] = new SelectList(_context.Clientes, "IdCliente", "IdCliente");
            ViewData["IdHabitacion"] = new SelectList(_context.Habitacions, "IdHabitacion", "IdHabitacion");
            return View();
        }

        // POST: Reservacions/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdReserva,NumeroReserva,IdHabitacion,CantidadPersonas,IdCliente,FechaIngreso,FechaSalida,HoraIngreso,HoraSalida,PoseeVehiculo,Estado")] Reservacion reservacion)
        {
            if (ModelState.IsValid)
            {
                _context.Add(reservacion);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IdCliente"] = new SelectList(_context.Clientes, "IdCliente", "IdCliente", reservacion.IdCliente);
            ViewData["IdHabitacion"] = new SelectList(_context.Habitacions, "IdHabitacion", "IdHabitacion", reservacion.IdHabitacion);
            return View(reservacion);
        }

        // GET: Reservacions/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var reservacion = await _context.Reservacions.FindAsync(id);
            if (reservacion == null)
            {
                return NotFound();
            }
            ViewData["IdCliente"] = new SelectList(_context.Clientes, "IdCliente", "IdCliente", reservacion.IdCliente);
            ViewData["IdHabitacion"] = new SelectList(_context.Habitacions, "IdHabitacion", "IdHabitacion", reservacion.IdHabitacion);
            return View(reservacion);
        }

        // POST: Reservacions/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdReserva,NumeroReserva,IdHabitacion,CantidadPersonas,IdCliente,FechaIngreso,FechaSalida,HoraIngreso,HoraSalida,PoseeVehiculo,Estado")] Reservacion reservacion)
        {
            if (id != reservacion.IdReserva)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(reservacion);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ReservacionExists(reservacion.IdReserva))
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
            ViewData["IdCliente"] = new SelectList(_context.Clientes, "IdCliente", "IdCliente", reservacion.IdCliente);
            ViewData["IdHabitacion"] = new SelectList(_context.Habitacions, "IdHabitacion", "IdHabitacion", reservacion.IdHabitacion);
            return View(reservacion);
        }

        // GET: Reservacions/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var reservacion = await _context.Reservacions
                .Include(r => r.IdClienteNavigation)
                .Include(r => r.IdHabitacionNavigation)
                .FirstOrDefaultAsync(m => m.IdReserva == id);
            if (reservacion == null)
            {
                return NotFound();
            }

            return View(reservacion);
        }

        // POST: Reservacions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var reservacion = await _context.Reservacions.FindAsync(id);
            if (reservacion != null)
            {
                _context.Reservacions.Remove(reservacion);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ReservacionExists(int id)
        {
            return _context.Reservacions.Any(e => e.IdReserva == id);
        }
    }
}

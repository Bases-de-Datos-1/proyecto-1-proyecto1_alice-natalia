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
    public class EmpresaRecreativasController : Controller
    {
        private readonly AppDbContext _context;

        public EmpresaRecreativasController(AppDbContext context)
        {
            _context = context;
        }

        // GET: EmpresaRecreativas
        public async Task<IActionResult> Index()
        {
            return View(await _context.EmpresaRecreativas.ToListAsync());
        }

        // GET: EmpresaRecreativas/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empresaRecreativa = await _context.EmpresaRecreativas
                .FirstOrDefaultAsync(m => m.IdEmpresaRecreativa == id);
            if (empresaRecreativa == null)
            {
                return NotFound();
            }

            return View(empresaRecreativa);
        }

        // GET: EmpresaRecreativas/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: EmpresaRecreativas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("IdEmpresaRecreativa,CedulaJuridicaEmpresa,NombreEmpresas,CorreoElectronico,NombrePersonal,NumeroTelefono")] EmpresaRecreativa empresaRecreativa)
        {
            if (ModelState.IsValid)
            {
                _context.Add(empresaRecreativa);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(empresaRecreativa);
        }

        // GET: EmpresaRecreativas/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empresaRecreativa = await _context.EmpresaRecreativas.FindAsync(id);
            if (empresaRecreativa == null)
            {
                return NotFound();
            }
            return View(empresaRecreativa);
        }

        // POST: EmpresaRecreativas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("IdEmpresaRecreativa,CedulaJuridicaEmpresa,NombreEmpresas,CorreoElectronico,NombrePersonal,NumeroTelefono")] EmpresaRecreativa empresaRecreativa)
        {
            if (id != empresaRecreativa.IdEmpresaRecreativa)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(empresaRecreativa);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!EmpresaRecreativaExists(empresaRecreativa.IdEmpresaRecreativa))
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
            return View(empresaRecreativa);
        }

        // GET: EmpresaRecreativas/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var empresaRecreativa = await _context.EmpresaRecreativas
                .FirstOrDefaultAsync(m => m.IdEmpresaRecreativa == id);
            if (empresaRecreativa == null)
            {
                return NotFound();
            }

            return View(empresaRecreativa);
        }

        // POST: EmpresaRecreativas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var empresaRecreativa = await _context.EmpresaRecreativas.FindAsync(id);
            if (empresaRecreativa != null)
            {
                _context.EmpresaRecreativas.Remove(empresaRecreativa);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool EmpresaRecreativaExists(int id)
        {
            return _context.EmpresaRecreativas.Any(e => e.IdEmpresaRecreativa == id);
        }
    }
}

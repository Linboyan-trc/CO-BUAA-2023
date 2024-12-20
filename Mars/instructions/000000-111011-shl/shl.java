import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class shl extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {
        // hi寄存器是33 lo寄存器是34
        int temp = RegisterFile.getValue(33);
        RegisterFile.updateRegister(33,RegisterFile.getValue(34));
        RegisterFile.updateRegister(34,temp);
    }

    @Override
    public String getExample() {
        return "shl";
    }

    @Override
    public String getDescription() {
        return "shl";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.R_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "000000 00000 00000 00000 00000 111011";
    }
}
